require "test_helper"

class CasesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cases_path
    assert_response :success
  end
end
