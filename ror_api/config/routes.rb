require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
    
  resources :merchants, except: [:new, :edit]

  root 'search#turtles'

  match 'search' => 'search#index', :via => :get
  
end
