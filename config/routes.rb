Rails.application.routes.draw do
  get 'jobs/index'
  root "jobs#index"

  resources :jobs

  post 'jobs/found', to: 'jobs#found'
end
