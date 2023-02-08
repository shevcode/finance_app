class TrendsController < ApplicationController
  before_action :set_trend, only: :trend_by_category

  class Trend
    include ActiveModel::Model
    validates :period, inclusion: { in: %w(week month) }
    validates :category_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }, allow_blank: true
    validates :ago, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 24 }, allow_blank: true
    attr_accessor :period, :ago, :category_id, :category_name, :sum_by_categories_and_periods
    def period
      @period ||= "month"
    end
    def ago
      @ago ||= 2
    end
  end

  def index
  end

  def trend_by_category
    @trend = Trend.new(@trends_params)
    if @trend.valid?
      @trend.period = @trends_params[:period]
      if @trend.category_id.present?
        @trend.category_name = Category.find(@trend.category_id).name
      else
        @trend.category_name = t('label_all') + ' ' + Category.model_name.human(:count => 2)
      end

      sum_by_categories_and_periods = Operation
        .joins(:category)
        .last_x_periods(@trend.ago.to_i, @trend.period)
        .type_is(2)
        .category_is(@trend.category_id)
        .group(:name)
        .group_by_period(@trend.period)
        .sum(:amount)
      

      
      hash_for_view = sum_by_categories_and_periods
        .group_by {|key, value| key[0] }
        .transform_values do |value|
          value.each {|item| item.flatten!.shift}
          .sort!
        end
             

      @trend.sum_by_categories_and_periods = hash_for_view


      respond_to do |format|
        format.html {
          flash[:notice] = @trend.model_name.human + ": "+ I18n.t('notice_successful_create')           
          render :trend_by_category
          }
        format.json { render :trend_by_category, status: :ok } #TODO correct JSON response
      end  
    else
      respond_to do |format|
        format.html { render :trend_by_category, status: :unprocessable_entity }
        format.json { render json: @trend.errors, status: :unprocessable_entity } 
      end 

    end
  end

  private
  def set_trend
    @trends_params = params.permit(:period, :ago, :category_id, :button).except(:button)
  end
end
