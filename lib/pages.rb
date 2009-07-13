module Beef
  module Pages
    module HelperMethods
      def get_template_names
        templates = []
        Dir.glob("#{RAILS_ROOT}/app/views/pages/templates/*"){|f| match = /\/([^\/]+)\.html\.erb$/.match(f); templates << match[1] unless match.nil? }
        # Move default to top if it exists
        if default = templates.delete('default')
          templates.insert(0, default)
        end 
        templates.sort
      end
    end
  end
end