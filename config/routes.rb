Rails.application.routes.draw do

  resources :businesses, only: [:show]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }
  # devise_for :users, controllers: { registrations: "registrations" }

  #devise requries defined root_url to *something* in your config/routes.rb.
  # devise setup for root folder (for building authentication by Jamie)
  # devise_scope :user do
  #   root to: "devise/registrations#new"
  # end
  # root to: ""

end
