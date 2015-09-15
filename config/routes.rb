Rails.application.routes.draw do
  get 'jobs/index'
  get 'jobs/parse_site'
  root "jobs#index"

  resources :jobs

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  post 'filter', to: 'jobs#filter', as: 'filter'
end
