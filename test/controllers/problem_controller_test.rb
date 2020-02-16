require 'test_helper'

class ProblemControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get problem_show_url
    assert_response :success
  end

end
