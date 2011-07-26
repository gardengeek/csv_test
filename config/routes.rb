CsvTest::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resource :state_search, :only => [:create, :new]

  resources :people
  resources :roles
  devise_for :users, :controllers => {:registrations => 'users/registrations'}
  devise_scope :user do
    root :to => "users/registrations#show", :constraints => lambda {|r| r.env["warden"].authenticate?}
    root :to => "devise/sessions#new"
    get "/" => "devise/sessions#new"
    post '/' => 'devise/sessions#new', :as => :new_user_session
    match '/', :to => 'devise/sessions#new'
    get '/sign_in' => 'devise/sessions#new'
    match '/sign_in', :to => 'devise/sessions#new'
    get '/sign_out' => 'devise/sessions#destroy'
    match '/sign_out', :to => 'devise/sessions#destroy'
  end

  resources :users, :except => [:new, :create]
  
  root :to => "users/registrations#show", :constraints => lambda {|r| r.env["warden"].authenticate?}
  root :to => "devise/sessions#new"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
