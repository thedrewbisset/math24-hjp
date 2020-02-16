require 'test_helper'

class SolutionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get solution_create_url
    assert_response :success
  end

end
