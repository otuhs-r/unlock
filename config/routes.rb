Rails.application.routes.draw do
  root 'users#index'
  resources :users
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
