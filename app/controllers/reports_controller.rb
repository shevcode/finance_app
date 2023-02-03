class ReportsController < ApplicationController
  before_action :set_report, only: %i[ report_by_category report_by_dates ]
  class Report
    include ActiveModel::Model
    attr_accessor :start_date, :end_date, :otype_name, :otype_id, :category_id, :category_name, :category_groups, :total
    validates :start_date, :end_date, :otype_id, presence: true 
    validates :start_date, :end_date, format: { with: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/ }
    validates :end_date, comparison: { greater_than_or_equal_to: :start_date }
  end

  def index
    
  end

  def report_by_category
    @report = Report.new(@report_params)
    if @report.valid?
      @report.category_groups = Operation.joins(:category).between_dates(@report.start_date, @report.end_date).type_is(@report.otype_id).group(:name).sum(:amount)
      @report.total = @report.category_groups.sum { |_, a| a }.round(2)  
      @report.otype_name = Otype.find(@report.otype_id).title
      respond_to do |format|
        format.html {
          flash[:notice] = @report.model_name.human + ": "+ I18n.t('notice_successful_create')           
          render :report_by_category
          }
        format.json { render :show, status: :ok } #TODO correct JSON response
      end  
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity } 
      end 

    end
  end

  def report_by_dates
    @report = Report.new(@report_params)
    if @report.valid?
      @report.otype_name = Otype.find(@report.otype_id).title
      if @report.category_id.present?
        @report.category_name = Category.find(@report.category_id).name
      else
        @report.category_name = t('label_all') + ' ' + Category.model_name.human(:count => 2)
      end
      operation_sums = Operation.between_dates(@report.start_date, @report.end_date).category_is(@report.category_id).type_is(@report.otype_id).group(:odate).sum(:amount)
      @dates = operation_sums.keys.map { |date| date.strftime("%F") }
      @amounts = operation_sums.values 
      respond_to do |format|
        format.html {
          flash[:notice] = @report.model_name.human + ": "+ I18n.t('notice_successful_create')           
          render :report_by_dates
          }
        format.json { render :show, status: :ok } #TODO correct JSON response
      end  
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity } 
      end
    end
  end

  private
  def set_report
    @report_params = params.permit(:start_date, :end_date, :otype_id, :category_id, :button).except(:button)
  end
end
