Mafia::Application.routes.draw do
  get '/galleries/:id-:alias' => 'photo_galleries#show', as: 'photo_gallery'
  get 'gallery' => 'photo_galleries#index'

  get '/news/:id-:alias' => 'articles#show', as: 'article'
  get '/news?category=:id-:alias' => 'articles#index', as: 'category'
  get 'news' => 'articles#index'

  get '/pages/:id-:alias' => 'pages#show', as: 'page'
  get 'contacts' => 'pages#contacts'
  get 'rating' => 'pages#rating'
  get 'game_all' => 'pages#game_all'
  root 'pages#home'

  get '/500' => 'errors#server_error'
  get '/422' => 'errors#server_error'
  get '/404' => 'errors#not_found'
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :games do
    get :rating, on: :collection
  end

  resources :members

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
