require 'test_helper'

class CasesControllerTest < ActionDispatch::IntegrationTest
  test 'should return success with data when database is empty' do
    Case.delete_all
    get cases_path
    cases = JSON.parse(response.body)['cases']

    assert_response :success
    assert_equal 30, cases.length
    assert_not_nil cases.sample['active_cumulative']
    assert Time.parse(cases.last['date_time']) >= Time.now.yesterday
  end

  test 'should return success with data when database is not updated' do
    Case.delete_all
    Case.collection.insert_one(
      positive: 1,
      active: 1,
      recover: 1,
      death: 1,
      positive_cumulative: 1,
      active_cumulative: 1,
      recover_cumulative: 1,
      death_cumulative: 1,
      last_update: 1,
      date_time: Time.now - 5.day
    )

    get cases_path
    cases = JSON.parse(response.body)['cases']

    assert_response :success
    assert_equal 30, cases.length
    assert_not_nil cases.sample['active_cumulative']
    assert Time.parse(cases.last['date_time']) >= Time.now.yesterday
  end
end
