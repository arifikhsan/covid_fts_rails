class CasesController < ApplicationController
  # jika database kosong, maka ambil baru
  # jika kasus di database tanggalnya beda dengan tanggal saat ini, maka sinkronkan
  # jika tidak, maka ambil dari database sebanyak 30 hari
  def index
    populate_new if Case.count.zero?
    sync unless data_uptodate?

    @cases = Case.order_by(date_time: :desc).limit(30).to_a
  end

  private

  def populate_new
    Case.collection.insert_many(remote_cases)
  end

  def sync
    remote_cases.map { |item| Case.where(key: item['key']).update(item) }
  end

  def data_uptodate?
    # kasus terakhir adalah kemarin atau hari ini
    Time.parse(Case.last.date_time).to_date >= Time.now.yesterday.to_date
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
