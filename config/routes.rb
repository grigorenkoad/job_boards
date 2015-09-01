Rails.application.routes.draw do
  get 'jobs/index'
  root "jobs#index"

  resources :jobs

  post 'filter', to: 'jobs#filter', as: 'filter'
end
