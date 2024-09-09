Rails.application.routes.draw do
  resources :proxies
  resources :newspapers
  resources :videos
  resources :lemmas
  resources :words
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: redirect("/newspapers?url=https://slobodnadalmacija.hr/split-i-zupanija")
end
