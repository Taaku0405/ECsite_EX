Rails.application.routes.draw do
 devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

 namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update] do
      get "orders" => "customers#orders"
    end

    resources :genres, only: [:index, :create, :edit, :update]

    resources :items, except: [:destroy]

    resources :orders, only: [:index, :show, :update]

    resources :order_details, only: [:update]

    get "search" => "searches#search"
  end
  
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show] do
      get :search, on: :collection
    end

    resource :customer, only: [:show, :edit, :update]
    get 'customers/quit', as: 'quit'
    patch 'customers/withdraw', as: 'withdraw'

    resources :shipping_addresses, only: [:create, :index, :edit, :update, :destroy]

    delete 'cart_items/empty', as: 'empty'
    resources :cart_items, only: [:index, :create, :update, :destroy]


    get 'orders/complete', as: 'complete'
    post 'orders/confirm', as: 'confirm'
    resources :orders, only: [:new, :create, :index, :show]

    get 'search' => 'searches#search'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
