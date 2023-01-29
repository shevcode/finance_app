class ReportsController < ApplicationController
  before_action :set_report, only: %i[ report_by_category report_by_dates ]
  class Report
    include ActiveModel::Model
    attr_accessor :start_date, :end_date, :otype_name, :otype_id, :category_id, :category_name, :category_groups, :total
    validates :start_date, :end_date, presence: true 
    validates :end_date, comparison: { greater_than: :start_date, message: 'must be greater than start date' }
  end
  class ReportByCategory < Report
    validates :otype_id, presence: true
  end
  class ReportByDates < Report
    validates :otype_id, :category_id, presence: true
  end

  def index
    
  end

  def report_by_category
    @report = ReportByCategory.new(@report_params)
    if @report.valid?
      @report.category_groups = Operation.joins(:category).where(otype: @report.otype_id, odate: @report.start_date..@report.end_date).group(:name).sum(:amount)
      @report.total = @report.category_groups.sum { |_, a| a }.round(2)  
      @report.otype_name = Otype.find(@report.otype_id).title
      respond_to do |format|
        format.html { render :report_by_category }
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
    @report = ReportByDates.new(@report_params)
    if @report.valid?
      @report.otype_name = Otype.find(@report.otype_id).title
      @report.category_name = Category.find(@report.category_id).name
      selected_operations = Operation.select(:id, :amount, :odate, :description).where(category: @report.category_id, otype: @report.otype_id, odate: @report.start_date..@report.end_date).order(:odate)
      operations_data = selected_operations.map { |o| [o.odate.to_s, o.amount] }
      @dates = operations_data.map { |o| o[0] }
      @amounts = operations_data.map { |o| o[1] }
      render :report_by_dates
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def set_report
    @report_params = params.permit(:start_date, :end_date, :otype_id, :category_id, :button).except(:button)
  end
end
