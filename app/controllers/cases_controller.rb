class CasesController < ApplicationController
  # jika database kosong, maka ambil baru
  # jika kasus di database tanggalnya lebih kecil dengan tanggal di remote, maka sinkronkan
  # jika tidak, maka ambil dari database sebanyak 30 hari
  def index
    populate_new if Case.count.zero?
    sync unless data_up_to_date?

    @cases = Case.order_by(date_time: :desc).limit(30).to_a
  end

  private

  def populate_new

    # binding.pry

    Case.collection.insert_many(remote_cases)
  end

  def sync
    remote = remote_cases
    local = Case.all.to_a

    # add if not exists
    remote.map do |remote_item|
      local_item = local.find { |i| i['key'] == remote_item['key'] }

      Case.collection.insert_one(remote_item) if local_item.nil?
    end

    # update if different
    a_month_from_remote = remote.sort_by { |i| i['key'] }.last(30)
    a_month_from_local = Case.order_by(key: :desc).limit(30).reverse.to_a
    a_month_from_remote.zip(a_month_from_local).each do |r, l|
      next unless r['active_cumulative'] != l['active_cumulative'] ||
                  r['last_update'] != l['last_update']

      # r['active'] != l['active'] ||
      # r['positive'] != l['positive'] ||
      # r['recover'] != l['recover'] ||
      # r['death'] != l['death'] ||
      # r['positive_cumulative'] != l['positive_cumulative'] ||
      # r['active_cumulative'] != l['active_cumulative'] ||
      # r['recover_cumulative'] != l['recover_cumulative'] ||
      # r['death_cumulative'] != l['death_cumulative']

      Case.find_by(key: l['key']).update(r)
    end
  end

  def data_up_to_date?
    # kasus terakhir adalah kemarin atau hari ini
    # Time.parse(Case.last.date_time).to_date >= Time.now.yesterday.to_date

    total = remote_total_cases
    Time.parse(Case.last.date_time).to_date >= Time.parse(total['updated_at']).to_date
  end

  def a_month_ago
    (Time.now - 1.month).utc.iso8601
  end

  def remote_cases
    get_from("#{base_url}/daily")
  end

  def remote_total_cases
    get_from("#{base_url}/last-update")
  end

  def get_from(url)
    JSON.parse(Excon.get(url).body)
  end

  def base_url
    ENV['API_COVID_URL'] || 'https://covid-fts-next.vercel.app/api'
  end
end
