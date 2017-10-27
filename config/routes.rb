Rails.application.routes.draw do

  #devise requries defined root_url to *something* in your config/routes.rb.
  root to: "business#index"
end
