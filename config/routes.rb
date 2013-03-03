Foundwithme::Application.routes.draw do
  
  get '/skills' => 'skills#index', :as => 'skills'
  get '/skills/import' => 'skills#import', :as => 'import_skills'
  
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

  #root to: 'root#index'
end
