require 'test_helper'

class CategoryControllerTest < ActionDispatch::IntegrationTest
  test "should get vie_scolaire" do
    get category_vie_scolaire_url
    assert_response :success
  end

end
