ActionController::Routing::Routes.draw do |map|
  map.resources :pages, :only => :show, :collection => {:preview => :get}
  map.namespace(:admin) do |admin|
    admin.resources :pages, :has_many => :pages, :collection => {:preview => :post}, :member => {:preview => :put, :feature => [:get, :put], :move_up => :get, :move_down => :get}
  end
end