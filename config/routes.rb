Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  #mainly static pages
  match '/home', to: 'main#index', via: [:get, :post]
  match '/about', to: 'main#about', via: [:get, :post]

  #contact pages
  get '/contact', to: 'messages#new', as: 'contact'
  post '/contact', to: 'messages#create'

  #login / logout pages
  get '/admin', to: 'sessions#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #ActiveRecord resource pages
  resources :products, path: 'gallery' do
    resources :item_images
    post 'addToOrder', on: :member
    post 'removeFromOrder', on: :member
  end

  resources :gallery_category

  resources :orders, only: [:show, :create,:destroy,:update] do
    patch 'payment_approved', on: :member
    get 'shipped', on: :member
    get 'completed', on: :member
  end
  get '/cart', to: 'orders#cart'
  get '/admin/orders', to: 'orders#manage'

end
