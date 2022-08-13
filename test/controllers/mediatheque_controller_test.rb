require 'test_helper'

class MediathequeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mediatheque_index_url
    assert_response :success
  end

end
