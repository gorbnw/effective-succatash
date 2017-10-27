Rails.application.routes.draw do

  resources :businesses, only: [:show]
end
