require 'test_helper'

class ShowTrackingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get show_tracking_index_url
    assert_response :success
  end

end
