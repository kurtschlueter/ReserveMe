Rails.application.routes.draw do

  root 'welcome#index'

  resources :welcome do
    get :search, :on => :collection
  end

  resources :restaurants do
    resources :reservations do
      get :availability_check, :on => :collection
    end
  end
end
