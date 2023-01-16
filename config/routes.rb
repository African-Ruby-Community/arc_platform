Rails.application.routes.draw do
  resources :countries
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'landing#index'

  get 'about', to: 'landing#about', as: :landing_about
end
