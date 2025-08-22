# frozen_string_literal: true

Rails.application.routes.draw do
  authenticate :user do
    mount Motor::Admin => '/admin'
  end
  resources :projects, only: %i[index show]
  resources :chapters, only: %i[index show]
  resources :countries, only: %i[index show]
  devise_for :users, controllers: {
    registrations: 'users/registrations', # Override devise registration controller
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'landing#index'

  get 'about_us', to: 'landing#about', as: :landing_about
  get 'learn', to: 'landing#learn', as: :landing_learn
end
