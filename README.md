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

## Commands

### heroku clean

heroku restart --app=covid-fts-rails && heroku pg:reset DATABASE --confirm covid-fts-rails --app=covid-fts-rails && heroku run rake db:migrate --app=covid-fts-rails

### seed on heroku

heroku restart --app=covid-fts-rails && heroku pg:reset DATABASE --confirm covid-fts-rails --app=covid-fts-rails && heroku run rake db:migrate db:seed --app=covid-fts-rails

### migrate and seed on heroku

heroku run rake db:migrate db:seed --app=covid-fts-rails

heroku run console --app=covid-fts-rails
heroku run bash --app=covid-fts-rails

### rebuild database locally

rake db:drop db:create db:migrate
rake db:drop db:create db:migrate db:seed
rake db:seed

### logs

heroku logs --tail --app covid-fts-rails

### secret key

EDITOR=vim rails credentials:edit
rails credentials:show

### Create Backup
heroku pg:backups:capture --app covid-fts-rails

### Download Backup
heroku pg:backups:download --app covid-fts-rails

### Restore
heroku pg:backups:restore --app covid-fts-rails --confirm covid-fts-rails
