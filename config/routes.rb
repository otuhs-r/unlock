Rails.application.routes.draw do
  root 'achievements#index'
  resources :users, only: [:show]
  resources :achievements, only: [:index, :new, :create]
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
