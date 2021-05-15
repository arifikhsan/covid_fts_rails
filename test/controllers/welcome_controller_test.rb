require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_path

    assert_response :success
    assert_select 'h2', 'Backend'
  end
end
