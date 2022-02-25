Frimar::Application.routes.draw do
  resources :requirements

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  
  resources :shipping_addresses
  resources :employees do
    resources :reminders, shallow: true
    member do
      get 'performance'
    end
  end
  resources :users do
    resources :reminders, shallow: true
  end
  resources :clients do
    resources :notes, shallow: true
    resources :contacts, shallow: true
    resources :documents, shallow: true
    collection do
      get 'list'
      get 'search'
      post 'import'
    end
  end

  resources :suppliers do
    resources :notes, shallow: true
    resources :contacts, shallow: true
    resources :documents, shallow: true
    collection do
      get 'list'
      get 'search'
      post 'import'
    end
  end

  resources :purchase_orders
  
  resources :opportunities do
    member do 
      get 'cotizacion'
    end
    collection do
      get 'open'
      get 'expired'
      get 'closed'
    end
  end

  resources :products do
    collection do
      post :import
    end
    member do
      get 'sell'
      get 'return'
    end
  end


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
