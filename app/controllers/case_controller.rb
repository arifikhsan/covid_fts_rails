class CaseController < ApplicationController
  before_action :populate_cases

  def index
    a_month_ago = (Time.now - 1.month).utc.iso8601
    @cases = Case.where(:datetime.gte => a_month_ago).to_a

    binding.pry

  end

  private

  def populate_cases
    return if Case.count.zero?

    response = Excon.get('https://covid-fts-next.vercel.app/api/daily')
    cases_json = JSON.parse(response.body)
    Case.collection.insert_many(cases_json)
  end
end
