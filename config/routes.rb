# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: 'welcome#index'
  get 'cases', to: 'case#index'
  get 'daily-case', to: 'case#index'
end
