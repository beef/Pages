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
  end
end