require 'test_helper'

class SetTrackingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get set_tracking_index_url
    assert_response :success
  end

end
