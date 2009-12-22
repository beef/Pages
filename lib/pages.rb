module Beef
  module Pages
    module HelperMethods
      def get_template_names
        templates = []
        Dir.glob("#{RAILS_ROOT}/app/views/pages/templates/*") do |f| 
          match = /\/([^\/]+)\.html\.erb$/.match(f)
          templates << match[1] unless match.nil?
        end
        # Move default to top if it exists
        if default = templates.delete('default')
          templates.insert(0, default)
        end 
        templates
      end
    end
    
    module UrlHelper
      def page_path(page, options = {})
        permalink = page.is_a?( Page ) ? page.permalink : page.to_s
        page_permalink_path(permalink,options)
      end
    
      def page_url(page, options = {}) 
        page_path(page, options.merge(:only_path => false)) 
      end
    end
  end
end