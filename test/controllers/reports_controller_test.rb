require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  # called before every single test
  setup do
    @earliest_date = Operation.order(:odate).first.odate
    

  end

  # called after every single test
  teardown do
    
    Rails.cache.clear
  end

  test "can see reports index" do
    get reports_index_path
    assert_response :success
    assert_select "h1", I18n.t('report_generator.title')
  end

  test "should create report by category" do
    get reports_report_by_category_path, params: { start_date: @earliest_date, end_date: Date.today, otype_id: Otype.first.id, category_id: Category.first.id }
    assert_response :success
    assert_select "h1", I18n.t('activemodel.models.reports_controller/report_by_category.one') + ": #{@earliest_date} - #{Date.today}"
    assert_equal I18n.t('activemodel.models.reports_controller/report_by_category.one') + ": "+ I18n.t('notice_successful_create'), flash[:notice]
  end

  test "should not create report_by_category and should render index with errors" do
    get reports_report_by_category_path, params: { end_date: Date.today, otype_id: Otype.first.id, category_id: Category.first.id }
    assert_response :unprocessable_entity
    assert_select "div[id=?]", "errors"
  end

  test "should create report by dates" do
    get reports_report_by_dates_path, params: { start_date: @earliest_date, end_date: Date.today, otype_id: Otype.first.id, category_id: Category.first.id }
    assert_response :success
    assert_select "h1", I18n.t('activemodel.models.reports_controller/report_by_dates.one') + ": #{@earliest_date} - #{Date.today}"
    assert_equal I18n.t('activemodel.models.reports_controller/report_by_dates.one') + ": "+ I18n.t('notice_successful_create'), flash[:notice]
  end

  test "should not create report_by_dates and should render index with errors" do
    get reports_report_by_dates_path, params: { end_date: Date.today, otype_id: Otype.first.id, category_id: Category.first.id }
    assert_response :unprocessable_entity
    assert_select "div[id=?]", "errors"
  end
  
end
