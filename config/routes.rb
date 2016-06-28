Rails.application.routes.draw do

  root 'welcome#index'

  resources :welcome do
    get :search, :on => :collection
  end
  resources :users
  resources :restaurants do
    resources :reservations do
      get :availability_check, :on => :collection
    end
  end
end
