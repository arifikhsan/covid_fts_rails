# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :admins
  root to: 'welcome#index'
  get 'cases', to: 'cases#index', format: 'json'
end
