Rails.application.routes.draw do
  root 'achievements#index'
  resources :users, only: %i[show edit] do
    resources :bookmarks, only: %i[create show update destroy]
  end
  resources :achievements, only: %i[index new create]
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get 'images/ogp.png', to: 'images#ogp', as: 'images_ogp'
end
