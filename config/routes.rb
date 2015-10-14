Rails.application.routes.draw do

  devise_for :users, skip: [:registrations, :sessions]
  as :user do
    # devise/registrations
    get 'signup' => 'devise/registrations#new', :as => :new_user_registration
    post 'signup' => 'devise/registrations#create', :as => :user_registration
    get 'users/register/cancel' => 'devise/registrations#cancel', :as => :cancel_user_registration
    get 'users/register/edit' => 'devise/registrations#edit', :as => :edit_user_registration
    put 'users/register' => 'devise/registrations#update'
    delete 'users/register/cancel' => 'devise/registrations#destroy'

    # devise/sessions
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    get 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get    'dashboard' => 'dashboard#index'
  get    'intro'     => 'welcome#intro'

  resources :users
  resources :groups
  resources :ticket_categories
  resources :tickets
  resources :businesses
  resources :asset_locations

  resources :assets, except: ['create', 'update', 'destroy']
  post 'assetprocs' => 'assets#create'
  put 'assetproc/:id' => 'assets#update'
  patch 'assetproc/:id' => 'assets#update'
  delete 'assetproc' => 'assets#destroy'

  resources :memberships
  resources :roles
  resources :profiles

  root 'dashboard#index'

end
