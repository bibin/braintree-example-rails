ActionController::Routing::Routes.draw do |map|
  map.signup '/signup', :controller => 'users', :action => "new"
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.resource :cart, :member => { :add    => :post,
                                   :update => :put,
                                   :remove => :delete,
                                   :clear  => :delete,
                                 }

  map.resources :orders, :member => { :checkout => :get,
                                     :status   => :get }
  map.resources :users
  map.resource :session

  map.resources :products

  # TO DELETE
  map.resources :payments, :collection => { :gateway_response => :get }

  map.root :controller => "products"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
