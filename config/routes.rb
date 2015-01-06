Depot::Application.routes.draw do
  resources :line_items do
    member do
      put 'decrement'
    end
  end

  resources :carts

  get "store/index"
  resources :products

  root "store#index", as: "store"
end
