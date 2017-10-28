Rails.application.routes.draw do


  resources :businesses, only: [:index, :show]
  resources :testimonials, only: [:show, :create]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  root to: "businesses#index"

end
