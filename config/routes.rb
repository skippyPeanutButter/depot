Depot::Application.routes.draw do
  resources :pay_types

  resources :orders

  resources :line_items do
    member do
      put 'decrement'
    end
  end

  resources :carts

  get "store/index"
  resources :products do
    get :who_bought, on: :member
  end

  root "store#index", as: "store"
end
