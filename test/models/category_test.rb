require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should not save article without title" do
    category = Category.new
    category.name = '21st_Category'
    category.description = '4rd description'
    #flunk( "Все пропало!" )
    assert category.save, "Saved the article "
  end
  
end
