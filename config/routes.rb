Rails.application.routes.draw do
  resources :videos
  resources :lemmas
  resources :words
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: redirect('/videos')
end
