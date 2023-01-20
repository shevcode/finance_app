require "test_helper"

class OtypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @otype = otypes(:one)
  end

  test "should get index" do
    get otypes_url
    assert_response :success
  end

  test "should get new" do
    get new_otype_url
    assert_response :success
  end

  test "should create otype" do
    assert_difference("Otype.count") do
      post otypes_url, params: { otype: { title: @otype.title } }
    end

    assert_redirected_to otype_url(Otype.last)
  end

  test "should show otype" do
    get otype_url(@otype)
    assert_response :success
  end

  test "should get edit" do
    get edit_otype_url(@otype)
    assert_response :success
  end

  test "should update otype" do
    patch otype_url(@otype), params: { otype: { title: @otype.title } }
    assert_redirected_to otype_url(@otype)
  end

  test "should destroy otype" do
    assert_difference("Otype.count", -1) do
      delete otype_url(@otype)
    end

    assert_redirected_to otypes_url
  end
end
