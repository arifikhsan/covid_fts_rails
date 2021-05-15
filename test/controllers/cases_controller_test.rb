require 'test_helper'

class CasesControllerTest < ActionDispatch::IntegrationTest
  test 'should return success when database is empty' do
    Case.delete_all
    get cases_path
    cases = JSON.parse(response.body)['cases']

    assert_response :success
    assert_equal 30, cases.length
    assert_not_nil cases.sample['active_cumulative']
  end
end
