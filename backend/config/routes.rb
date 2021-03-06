Rails.application.routes.draw do
  # resources :admins do
  get 'admins' => 'rails_admin/main#dashboard'
  get '/admin/sign_in' => 'admins#new'
  post '/admin/sign_in' => 'admins#create'

  # end
  mount RailsAdmin::Engine => '/admins', as: 'rails_admin'

  


  resources :user
  resources :posts
  resources :menus
  get 'home/index'
  root to: 'home#index'

  devise_for :users
  get 'users/profile/' => 'home#showuser'
  get 'users/profile_password/' => 'home#password'
  put 'users/profile_update' => 'home#update_password'

  # devise_for :admins
  # mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'
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
