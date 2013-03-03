Foundwithme::Application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'authentications', registrations: "registrations"}

    match '/auth/failure', :to => 'authentications#failure'

  authenticated :user do
    root :to => 'users#index'
  end
  
  as :user do
    root to: "devise/sessions#new"
  end

  #root to: 'root#index'
end
