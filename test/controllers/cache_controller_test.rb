require "test_helper"

class CacheControllerTest < ActionDispatch::IntegrationTest
  test "should get refresh" do
    get cache_refresh_url
    assert_response :success
  end
end
