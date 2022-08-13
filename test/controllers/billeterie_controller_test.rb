require 'test_helper'

class BilleterieControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get billeterie_index_url
    assert_response :success
  end

end
