Rails.application.routes.draw do
  resources :accounts, only: [:create]
  resources :payments
  resource :wallet
end
