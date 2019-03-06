Rails.application.routes.draw do
  root 'achievements#index'
  resources :users, only: [:show] do
    resources :bookmarks, only: %i[create update destroy]
  end
  resources :achievements, only: %i[index new create]
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
