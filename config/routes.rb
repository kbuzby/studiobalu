Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  #mainly static pages
  match '/home', to: 'main#index', via: [:get, :post]
  match '/about', to: 'main#about', via: [:get, :post]
  match '/contact', to: 'main#contact', via: [:get, :post]

  #login / logout pages
  get '/admin', to: 'sessions#new'
  post '/admin', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #ActiveRecord resource pages
  resources :users, only: [:new, :create, :edit, :destroy]

end