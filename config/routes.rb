Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :achievements, only: [:index, :show, :new, :create]
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
