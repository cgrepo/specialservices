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
      post 'actResponsable',        action:'actResponsable',    controller:'people', as:'actResponsable'
      put  'updatePerson/:id',      action:'updatePerson',      controller:'people', as:'updatePerson'
      put  'updateResponsable/:id', action:'updateResponsable', controller:'people', as:'updateResponsable'
      post 'addRelatives',          action:'addRelatives',      controller:'people', as:'addRelatives'
      post 'addPicture',            action:'addPicture',        controller:'people', as:'addPicture'
    end
  end
  resources :expeditures, :living_places, :responsables, :relatives, only: [ :index ]
  resources :other_expeditures, :benefits, :other_services, only: [ :index, :show, :create, :destroy ]
  resources :sessions, only:[:new, :create, :destroy]
  get "/login" => "sessions#new", as: "login"
  get 'welcome/index'
  delete "/logout" => "sessions#destroy", as: "logout"
  root to: 'welcome#index'
end
