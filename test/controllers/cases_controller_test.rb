require 'test_helper'

class CasesControllerTest < ActionDispatch::IntegrationTest
  test 'should return success with data when database is empty' do
    Case.collection.drop
    get cases_path
    cases = JSON.parse(response.body)['cases']

    assert_response :success
    assert_equal 30, cases.length
    assert_not_nil cases.sample['active_cumulative']
    assert Time.parse(Case.last.date_time).to_date >= Time.now.yesterday.to_date
  end

  test 'should return success with data when database is not updated' do
    Case.collection.drop
    get cases_path
    Case.last.destroy
    get cases_path
    cases = JSON.parse(response.body)['cases']

    assert_response :success
    assert_equal 30, cases.length
    assert_not_nil cases.sample['active_cumulative']
    assert Time.parse(Case.last.date_time).to_date >= Time.now.yesterday.to_date
  end

  test 'should return success with data when database is updated' do
    Case.collection.drop
    get cases_path
    Case.last.update(date_time: Time.now)
    get cases_path

    cases = JSON.parse(response.body)['cases']

    assert_response :success
    assert_equal 30, cases.length
    assert_not_nil cases.sample['active_cumulative']
    assert Time.parse(Case.last.date_time).to_date >= Time.now.yesterday.to_date
  end
end
