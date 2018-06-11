Rails.application.routes.draw do
  resources :accounts, only: [:create] do
    collection do
      get :me
    end
  end
  resources :payments
  resource :wallet

  get :/, to: 'root#index'
end
