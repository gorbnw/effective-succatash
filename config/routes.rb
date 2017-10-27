Rails.application.routes.draw do

  resources :businesses, only: [:index, :show]
  resources :testimonials, only: [:create]
end
