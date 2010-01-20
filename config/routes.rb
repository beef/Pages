ActionController::Routing::Routes.draw do |map|
  map.preview_pages 'pages/preview.:format', :controller => 'pages', :action => 'preview'
  map.page_permalink 'pages/:id.:format', :controller => 'pages', :action => 'show'
  map.namespace(:admin) do |admin|
    admin.resources :pages, :has_many => :pages, :collection => {:preview => :post}, :member => {:preview => :put, :move_up => :get, :move_down => :get}
  end
end