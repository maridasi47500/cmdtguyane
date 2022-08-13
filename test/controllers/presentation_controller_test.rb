require 'test_helper'

class PresentationControllerTest < ActionDispatch::IntegrationTest
  test "should get lecmdtg" do
    get presentation_lecmdtg_url
    assert_response :success
  end

end
