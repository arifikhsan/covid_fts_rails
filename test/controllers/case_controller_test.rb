require "test_helper"

class CaseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get case_index_url
    assert_response :success
  end
end
