require "application_system_test_case"

class OtypesTest < ApplicationSystemTestCase
  setup do
    @otype = otypes(:one)
  end

  test "visiting the index" do
    visit otypes_url
    assert_selector "h1", text: "Otypes"
  end

  test "should create otype" do
    visit otypes_url
    click_on "New otype"

    fill_in "Title", with: @otype.title
    click_on "Create Otype"

    assert_text "Otype was successfully created"
    click_on "Back"
  end

  test "should update Otype" do
    visit otype_url(@otype)
    click_on "Edit this otype", match: :first

    fill_in "Title", with: @otype.title
    click_on "Update Otype"

    assert_text "Otype was successfully updated"
    click_on "Back"
  end

  test "should destroy Otype" do
    visit otype_url(@otype)
    click_on "Destroy this otype", match: :first

    assert_text "Otype was successfully destroyed"
  end
end
