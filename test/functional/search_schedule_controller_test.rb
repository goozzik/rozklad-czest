require 'test_helper'

class SearchScheduleControllerTest < ActionController::TestCase
  test "should get new_search" do
    get :new_search
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
