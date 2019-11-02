Rails.application.routes.draw do
  devise_for :users
  resources :products do
    member do
      post :add_to_cart
    end
  end

  resources :carts do
    collection do
      delete :clean
    end
  end

  namespace :admin do
    resources :posts
    resources :products
  end
  root 'products#index'
  # get 'welcome/index'
  # root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
