require "test_helper"

class TrendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trends_index_url
    assert_response :success
  end

  test "should get trend_by_category" do
    get trends_trend_by_category_url
    assert_response :success
  end
end
