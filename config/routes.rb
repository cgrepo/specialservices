Rails.application.routes.draw do
  resources :users, only:[:new, :create, :destroy] do
    collection do
      get 'editPass/:id', action:'editPass', controller:'users', as:'editPass'
      post 'updatePass/:id', action:'updatePass', controller:'users', as:'updatePass'
    end
  end
  resources :requests do
    collection do
      get 'showmodal', to: 'requests#showmodal'
      get 'showPDF',   to: 'requests#showPDF'
    end
  end
  resources :people do
    collection do
      post 'addResponsable',        action:'addResponsable',    controller:'people', as:'addResponsable'
      put  'updatePerson/:id',      action:'updatePerson',      controller:'people', as:'updatePerson'
      put  'updateResponsable/:id', action:'updateResponsable', controller:'people', as:'updateResponsable'
      post 'addRelatives',          action:'addRelatives',      controller:'people', as:'addRelatives'
    end
  end
  resources :expeditures , :benefits, :other_services, :other_expeditures, :living_places,
            :responsables, :relatives, only: [ :index ]
  #resources :otherservices, only: [ :index ]
  resources :sessions, only:[:new, :create, :destroy]
  get "/login" => "sessions#new", as: "login"
  delete "/logout" => "sessions#destroy", as: "logout"
  get 'welcome/index'
  root to: 'welcome#index'
#--------HIDER-----------------
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
