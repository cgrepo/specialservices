Rails.application.routes.draw do
  get 'other_services/update'

  get 'gears/index'
  get 'gears/nuke'
  resources :users, only:[:new, :create, :destroy] do
    collection do
      get 'editPass/:id', action:'editPass', controller:'users', as:'editPass'
      post 'updatePass/:id', action:'updatePass', controller:'users', as:'updatePass'
    end
  end
  resources :requests do
    collection do
      get 'showmodal', to: 'requests#showmodal'
      get 'showPDF/:id',        action:'showPDF',       controller:'requests', as:'showPDF'
      get 'edOExpediture/:id',  action:'edOExpediture', controller:'requests', as:'edOExpediture'
      get 'edBenefit/:id',      action:'edBenefit',     controller:'requests', as:'edBenefit'
      get 'edOService/:id',     action:'edOService',    controller:'requests', as:'edOService'
    end
  end
  resources :people do
    collection do
      put  'updatePerson/:id',      action:'updatePerson',      controller:'people', as:'updatePerson'
      post 'addResponsable',        action:'addResponsable',    controller:'people', as:'addResponsable'
      post 'actResponsable',        action:'actResponsable',    controller:'people', as:'actResponsable'
      put  'updateResponsable/:id', action:'updateResponsable', controller:'people', as:'updateResponsable'
      post 'addRelatives',          action:'addRelatives',      controller:'people', as:'addRelatives'
      post 'addPicture',            action:'addPicture',        controller:'people', as:'addPicture'
    end
  end
  resources :relatives, only: [ :index, :update, :destroy, :edit, :create, :new ]
  resources :expeditures, :living_places,  :responsables, only: [ :index, :update ]
  resources :other_expeditures, :benefits, :other_services, only: [ :index, :show, :create, :destroy, :update ]
  resources :sessions, only:[:new, :create, :destroy]
  get "/login" => "sessions#new", as: "login"
  get 'welcome/index'
  delete "/logout" => "sessions#destroy", as: "logout"
  root to: 'welcome#index'
end
