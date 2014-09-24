RateMyTaxi::Application.routes.draw do

  root 'static_pages#home'
  devise_for :users do
    get '/new_review', to: 'users#initial_review_for_new_user', as: 'initial_review_for_new_user'
  end


  resources :users do
    resources :reviews
    resources :taxis
  end

  resources :questions, only: [:show, :edit, :update, :destroy, :remove_question]
  resources :answers

  #custom route for find_taxi and submitting a review
  match '/survey/new', to: 'answers#new_answer_review', via: 'get'
  match '/survey/create', to: 'answers#create_answer_review', via: 'post'

  #custom routes for graphs and total answer tallies
  match '/most_reviews/', to: 'taxis#most_reviews', via: 'get'
  match '/answer_graphs/', to: 'taxis#graphs', via: 'get'
  match '/review_comments/', to: 'taxis#comments', via: 'get'

  #remove and review_id from question instead of permanently deleting it
  match '/remove/:id/question/', to: 'reviews#remove_question', :as => 'remove_question', via: 'post'

  #generate QR Code based on url for search + taxi_id
  match '/create_qr_code/:id/', to: 'qr_codes#create_qr_code', :as => 'create_qr_code', via: 'get'

  #select which review will show up to potential reviewers
  match '/users/:user_id/review/:id/select_for_use', to: 'reviews#select_for_use', :as => 'select_for_use', via: 'post'


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
