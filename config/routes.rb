NBM::Application.routes.draw do
  resources :users
  
  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new'
    match '/signin',  to: 'sessions#new'
    match '/signout', to: 'sessions#destroy', via: :delete
    


  match "/report/food_visit", :to => "report#food_visit", :as => "report_food_visit"
  match "/report/shower_visit", :to => "report#shower_visit", :as => "report_shower_visit"
  
  match "/search_people", :to => "people#search"
  match "/search_food_visits", :to => "food_visits#search"
  match "/pending_food_visits", :to => "food_visits#pending"
  match "/food_visits/:id/processed", :to => "food_visits#processed", as: "processed_food_visit", via: [:post]
  
  match "/search_shower_visits", :to => "shower_visits#search"
  match "/pending_shower_visits", :to => "shower_visits#pending"
  match "/shower_visits/:id/processed", :to => "shower_visits#processed", as: "processed_shower_visit", via: [:post]
  
  root to: 'people#search'
  
  resources :shower_visits

  resources :food_visits, only: [:new, :edit, :create, :update, :destroy]

  resources :people

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
