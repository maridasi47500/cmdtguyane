require 'test_helper'

class DanseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get danse_index_url
    assert_response :success
  end

end
