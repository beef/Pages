require "pages"

ActionView::Base.send :include, Beef::Pages::UrlHelper
ActionController::Base.send :include, Beef::Pages::UrlHelper