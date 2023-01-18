class ReportsController < ApplicationController
  before_action :set_report, only: %i[ report_by_category report_by_dates ]

  def index
  end

  def report_by_category

  end

  def report_by_dates
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report_params = params

  end

  # Only allow a list of trusted parameters through. DO I NEED THIS METHOD TO CHECK PARAMETERS FROM REQUEST?
  def report_params
    params.permit(:start, :end)
  end
end
