require 'test_helper'

class LocationControllerTest < ActionDispatch::IntegrationTest
  test "should get instrument" do
    get location_instrument_url
    assert_response :success
  end

  test "should get salle" do
    get location_salle_url
    assert_response :success
  end

end
