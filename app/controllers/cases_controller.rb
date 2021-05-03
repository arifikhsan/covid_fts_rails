class CasesController < ApplicationController
  before_action :populate_cases

  def index
    a_month_ago = (Time.now - 1.month).utc.iso8601
    @cases = Case.where(:date_time.gte => a_month_ago).to_a
  end

  private

  def populate_cases
    # TODO: cek jika ada kasus yang baru,
    # jika ada yang baru, maka ambil semua data
    # return unless Case.count.zero?

    response = Excon.get('https://covid-fts-next.vercel.app/api/daily')
    cases_json = JSON.parse(response.body)
    Case.collection.insert_many(cases_json)
  end
end
