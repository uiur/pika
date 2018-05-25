Rails.application.routes.draw do
  resources :accounts
  resources :payments
  resource :wallet
end
