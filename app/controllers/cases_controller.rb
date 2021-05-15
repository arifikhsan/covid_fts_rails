class CasesController < ApplicationController
  # jika database kosong, maka ambil baru
  # jika kasus di database tanggalnya beda dengan tanggal saat ini, maka sinkronkan
  # jika tidak, maka ambil dari database sebanyak 30 hari
  def index
    populate_new if Case.count.zero?
    sync unless is_data_uptodate?

    @cases = Case.where(:date_time.gte => a_month_ago).to_a
  end

  private

  def populate_new
    Case.collection.insert_many(remote_cases)
  end

  def sync
    remote_cases.map do |item|
      Case.new(item).upsert
    end
  end

  def is_data_uptodate?
    # kasus terakhir adalah kemarin atau hari ini
    Time.parse(Case.last.date_time) >= Time.now.yesterday
  end

  def a_month_ago
    (Time.now - 1.month).utc.iso8601
  end

  def remote_cases
    get_from(covid_url)
  end

  def get_from(url)
    JSON.parse(Excon.get(url).body)
  end

  def covid_url
    'https://covid-fts-next.vercel.app/api/daily'
  end
end
