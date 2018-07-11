require 'sidekiq/web'


Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  
  authenticated :user do
    root 'modules#index', as: :authenticated_root
  end
  root to: "home#index"
  
  resources :portfolios
  resources :holdings
  resources :transactions do
    collection do
      get 'purchase'
      get 'sale'
      post 'import'
    end
  end
  resources :securities do
    collection do
      post 'get_list'
      get :search
      get :load_institutional_holders
      get :load_earnings_chart
      
    end
  end
  
  resources :modules do
    collection do
      get 'portfolios'
    end
  end
  
  resources :quotes do
    collection do
      get 'get_quick_quote'
    end 
  end
  
  resources :balances 
  
  # get '/quick_quote' => 'application#get_quick_quote', as: '/quick_quote'
  # get '/render_quick_quote' => 'application#render_quick_quote', as: 'render_quick_quote'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
