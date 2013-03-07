Cost::Application.routes.draw do
  get "cost_report/organization_months"
  get "cost_report/category_months"

  get "organizations_cost" => 'cost_report#organizations_cost'
  get 'organization_cost' => 'cost_report#organization_cost'

  get 'category_cost/:category_id' => 'cost_report#category_cost'
  match 'reimbursement_list/:category_id-:organization_id-:month' => 'cost_report#reimbursement_list', :as => :reimbursement_list,
    :constraints => {:category_id => /(\d+)|(\*)/, :organization_id => /(\d+)|(\*)/, :month => /\d{1,2}|(\*)/}
  match 'detail_list/:category_id-:organization_id-:month' => 'cost_report#detail_list', :as => :detail_list,
    :constraints => {:category_id => /(\d+)|(\*)/, :organization_id => /(\d+)|(\*)/, :month => /\d{1,2}|(\*)/}


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

  root :to => 'home#index'

end
