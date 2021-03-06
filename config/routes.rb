Foundwithme::Application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'authentications', registrations: "registrations"}

  match '/auth/failure', :to => 'authentications#failure'

  authenticated :user do
    post '/update_user_skills', to: 'users#update_user_skills', as: 'update_user_skills'
    post '/update_user_interests', to: 'users#update_user_interests', as: 'update_user_interests'
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

  namespace :interests do
    get :search
  end

  resources :skills, except: [:edit, :update, :delete]
  resources :interests, except: [:edit, :update, :delete]
  resources :messages, only: [:create]
  resources :charges, only: [:create]
end
