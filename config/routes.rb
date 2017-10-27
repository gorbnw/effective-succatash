Rails.application.routes.draw do


  #devise requries defined root_url to *something* in your config/routes.rb.
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }


  #devise setup for root folder (for building authentication by Jamie)
  devise_scope :user do
    root to: "devise/registrations#new"
  end
end
