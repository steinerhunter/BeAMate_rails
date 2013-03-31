BeAMateRails::Application.routes.draw do

  resources :invitations
  resources :users
  resources :password_resets
  resources :sessions, only: [:new, :create, :destroy]
  resources :requestposts, only: [:create, :destroy]
  resources :mateposts, only: [:create, :destroy]
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  root to: 'static_pages#home'

  match '/signup', to: 'users#new', as: 'signup'
  match '/signup_with_token/:invitation_token', to: 'users#new', as:'signup_with_token'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/howitworks', to: 'static_pages#how_it_works'
  match '/request', to: 'static_pages#request_item'
  match '/mate', to: 'static_pages#matepost_item'

  match '/invite', to: 'invitations#new'

  match '/reset_password', to: 'password_resets#new'

  match '/contact', to: 'contact#new', :as => 'contact', :via => :get
  match '/contact', to: 'contact#create', :as => 'contact', :via => :post

  match "empty_trash" => "users#empty_trash"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
