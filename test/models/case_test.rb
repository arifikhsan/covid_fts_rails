require "test_helper"

class CaseTest < ActiveSupport::TestCase
  test 'can create case' do
    new_case = Case.new(
      key: 1,
      positive: 1,
      active: 1,
      recover: 1,
      death: 1,
      positive_cumulative: 1,
      active_cumulative: 1,
      recover_cumulative: 1,
      death_cumulative: 1,
      last_update: 1,
      date_time: '2021-03-03T00:00:00.00Z'
    )
    assert new_case.save
  end
end
