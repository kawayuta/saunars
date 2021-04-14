Rails.application.routes.draw do
  resources :sauna_tags
  resources :sauna_rooms
  resources :sauna_amenities
  resources :sauna_roles
  resources :saunas do
    get :search , on: :collection
  end
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
   }
  resources :users
  root 'users#index'

  get 'search', to: 'saunas#search'

  resources :wents, only: [:create, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

   # token auth routes available at /api/v1/auth
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/auth/registrations',
        sessions: 'api/auth/sessions',
    }
 end
end