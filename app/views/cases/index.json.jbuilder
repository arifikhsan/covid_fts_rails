json.cases @cases do |item|
  json.id item.id.to_s
  # json.positive item.positive
  # json.active item.active
  # json.recover item.recover
  # json.death item.death
  # json.positive_cumulative item.positive_cumulative
  json.active_cumulative item.active_cumulative
  # json.recover_cumulative item.recover_cumulative
  # json.death_cumulative item.death_cumulative
  # json.last_update item.last_update
  json.date_time item.date_time
end
