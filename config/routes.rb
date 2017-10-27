Rails.application.routes.draw do

  resources :businesses, only: [:index, :show]
  resources :testimonials, only: [:show, :create]
end
