require "test_helper"

class RaclettesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get raclettes_index_url
    assert_response :success
  end
end
