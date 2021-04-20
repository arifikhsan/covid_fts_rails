class CaseController < ApplicationController
  before_action :populate_cases

  def index
    @cases = Case.all

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
