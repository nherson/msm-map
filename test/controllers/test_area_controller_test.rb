require "test_helper"

class TestAreaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_area_index_url
    assert_response :success
  end
end
