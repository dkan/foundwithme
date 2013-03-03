Foundwithme::Application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'authentications', registrations: "registrations"}

  match '/auth/failure', :to => 'authentications#failure'

  authenticated :user do
    root :to => 'users#index'
    get 'users', to: 'users#index', as: 'users_path'
  end
  
  as :user do
    root to: "devise/sessions#new"
  end

  resources :skills, except: [:update, :delete]

  namespace :skills do
    get :import
  end

  resources :charges, only: [:create]
end
