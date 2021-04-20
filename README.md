# COVID-19 Fuzzy Time Series Prediction

## Model

rails generate model case positive:integer active:integer recover:integer death:integer positive_cumulative:integer active_cumulative:integer recover_cumulative:integer death_cumulative:integer last_update:integer date_time:date_time

## Case

```json
{
"positive": 2,
"active": 2,
"recover": 0,
"death": 0,
"positive_cumulative": 2,
"active_cumulative": 2,
"recover_cumulative": 0,
"death_cumulative": 0,
"last_update": 1583107200000,
"datetime": "2020-03-02T00:00:00.000Z"
}
```
"2020-03-02T00:00:00.000Z"
Time.now.utc.iso8601
