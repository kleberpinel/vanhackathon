Rails.application.routes.draw do
  
  resources :merchants, except: [:new, :edit]

  root 'search#turtles'

  match 'search' => 'search#index', :via => :get
  
end
