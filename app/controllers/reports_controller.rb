class ReportsController < ApplicationController
  before_action :set_report, only: %i[ report_by_category report_by_dates ]
  class Report
    include ActiveModel::Model
    attr_accessor :start_date, :end_date, :otype_name, :otype_id, :category_id, :category_groups, :total
    validates :start_date, :end_date, presence: true #TODO check: 1)second date > first date  2)at least one date is not blank
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
      @report.category_groups = 
        Operation
          .joins(:category)
          .where(otype: @report.otype_id, odate: @report.start_date..@report.end_date)
          .group(:name)
          .sum(:amount)
          
      @report.total = @report.category_groups.sum { |_, a| a }  
      @report.otype_name = Otype.find(@report.otype_id).title
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
