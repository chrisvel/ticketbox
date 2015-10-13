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
  resources :assets
  resources :memberships
  resources :roles
  resources :profiles do
    get 'profiles/:id', to: 'profiles#update'
  end

  root 'dashboard#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
