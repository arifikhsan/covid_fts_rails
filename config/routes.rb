# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :admins
  root to: 'welcome#index'
  get 'cases', to: 'cases#index', format: 'json'
  # match "*path", :to => proc {|env| [200, {
  #   'Access-Control-Allow-Origin' => '*',
  #   'Access-Control-Allow-Methods' => 'GET, POST, PUT, DELETE, OPTIONS',
  #   'Access-Control-Allow-Credentials' => 'true',
  #   'Access-Control-Request-Method' => '*',
  #   'Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept, Authorization',
  # 'Content-Type' => 'text/plain'

  #  }, ["CORS Preflight"]] }, :via => [:options]
end
