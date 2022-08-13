require 'test_helper'

class PĥotosControllerTest < ActionDispatch::IntegrationTest
  test "should get saison20202021" do
    get pĥotos_saison20202021_url
    assert_response :success
  end

end
