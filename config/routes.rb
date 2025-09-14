Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "products#index"
  resources :products
  resources :subscribers, only: [ :create ]
  resources :unsubscribe, only: [ :show ]
end
