Rails.application.routes.draw do


  resources :businesses do
    collection do
      get :search, :action => 'search', as: 'search'
      get :offset, :action => 'offset', as: 'offset'
    end
  end
  resources :votes, only: [:create]
  resources :testimonials, only: [:show, :create]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }

  root to: "businesses#index"

  get '/about', to: 'home#about', as: 'about'
end
