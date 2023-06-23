Rails.application.routes.draw do
  resources :items
  resources :sales

  root to: 'items#index'
end
