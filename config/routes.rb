Foundwithme::Application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'authentications', registrations: "registrations"}

  match '/auth/failure', :to => 'authentications#failure'

  get '/profile', to: 'users#profile'

  authenticated :user do
    root :to => 'users#index'
    resources :users
  end
  
  as :user do
    root to: "devise/sessions#new"
  end

  resources :users, except: [:update, :delete]

  namespace :skills do
    get :import
    get :search
  end

  resources :skills, except: [:update, :delete]
  resources :messages, only: [:create]
  resources :charges, only: [:create]
end
