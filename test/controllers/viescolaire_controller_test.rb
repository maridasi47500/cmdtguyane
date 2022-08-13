require 'test_helper'

class ViescolaireControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get viescolaire_index_url
    assert_response :success
  end

end
