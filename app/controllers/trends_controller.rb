class TrendsController < ApplicationController
  before_action :set_trend, only: :trend_by_category

  class Trend
    include ActiveModel::Model
    validates :period, inclusion: { in: %w(week month) }
    validates :category_id, :period, presence: true
    validates :category_id, format: { with: /\d{1,2}/ }
    attr_accessor :period, :category_id, :category_name
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

      category_sum_last_month = Operation.last_month.category_is(@trend.category_id).type_is(2).sum(:amount)
      p category_sum_last_month


      respond_to do |format|
        format.html {
          flash[:notice] = @trend.model_name.human + ": "+ I18n.t('notice_successful_create')           
          render :trend_by_category
          }
        format.json { render :trend_by_category, status: :ok } #TODO correct JSON response
      end  
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @trend.errors, status: :unprocessable_entity } 
      end 

    end
  end

  private
  def set_trend
    @trends_params = params.permit(:period, :category_id)
  end
end
