class ReportsController < ApplicationController
  before_action :set_report, only: %i[ report_by_category report_by_dates ]
  class Report
    include ActiveModel::Model
    attr_accessor :start_date, :end_date, :otype_name, :otype_id, :category_id, :category_groups, :total
    validates :start_date, :end_date, :otype_id, :category_id, presence: true
  end

  def index
    
  end

  def report_by_category
    @report = Report.new(@report_params)
    if @report.valid?
      category_groups = Operation.select(:category_id, :amount).where(otype: @report.otype_id, odate: @report.start_date..@report.end_date).group(:category_id).sum(:amount)
      @report.total = category_groups.sum { |_, a| a }
      @report.otype_name = Otype.find(@report.otype_id).title
      categories = Category.select(:id, :name).where(id: category_groups.keys).index_by(&:id)  #one request to Category table instead many requests to find each category name
      @report.category_groups = category_groups.transform_keys { |key| categories[key].name }
      render :report_by_category
    else
      render :index, status: :unprocessable_entity
    end
 
  end

  def report_by_dates
  end

  private
  def set_report
    @report_params = params.permit(:start_date, :end_date, :otype_id, :category_id, :commit).except(:commit)
  end
end
