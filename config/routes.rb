Cost::Application.routes.draw do
  get "cost_report/organization_months"
  get "cost_report/category_months"
  get "cost_report/query_details"
  get 'query_reimbursement_details/:category_id-:organization_id-:month', :to => 'cost_report#query_details'

  get "lookup/cost_names", :defaults => { :format => 'json' }
  get "lookup/units", :defaults => { :format => 'json' }

  get "home/index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"

  resources :sessions
  resources :categories
  resources :users
  resources :organizations
  resources :periods do
    get :current, :on => :collection
  end
  
  resources :expenses do
    get :generate_sn, :on => :collection, :defaults => { :format => 'json' }

    get :query, :on => :collection
    get :verify, :on => :member
    put :commit, :on => :member
    put :discard, :on => :member
    resources :approvals, :only => [:new, :create, :show]
    resources :reimbursements, :only => [:new]
  end
  resources :approvals, :only => [:index]

  resources :reimbursements do
    get :generate_sn, :on => :collection, :defaults => { :format => 'json' }
    
    get :query, :on => :collection
    get :verify, :on => :member
    put :commit, :on => :member
    get :query_expenses, :on => :collection
    get :list_verify, :on => :collection
    get :query_details, :on => :collection
  end
  resources :details, :only => [:query]
  get 'details/:category_id-:organization_id-:month', :to => 'details#query'
  # match '/:year/:month/:day/:slug', :to => 'articles#show', :constraints => {:year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/ }

  root :to => 'home#index'


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
