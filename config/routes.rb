Rails.application.routes.draw do

  root 'welcome#index'

  resources :welcome do
    get :search, :on => :collection
  end

end
