Rails.application.routes.draw do
  authenticate :user do
    mount Motor::Admin => '/admin'
  end
  resources :projects
  resources :chapters
  resources :countries
  devise_for :users, controllers: {
    registrations: 'users/registrations', # Override devise registration controller
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'landing#index'

  get 'about', to: 'landing#about', as: :landing_about
end
