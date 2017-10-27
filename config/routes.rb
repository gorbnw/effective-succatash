Rails.application.routes.draw do

  resources :businesses, only: [:show]
  resources :testimonials, only: [:create]
end
