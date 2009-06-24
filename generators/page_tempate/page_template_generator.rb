class PageTemplateGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.directory(File.join('app', 'views', 'pages', 'templates')) 
      
      m.file('default.html.erb', File.join('app', 'views', 'pages', 'templates', '_default.html.erb'))
      m.file('default.html.erb', File.join('app', 'views', 'pages', 'templates', "_#{name}.html.erb")) unless name.blank? or name == 'default'
    end
  end
  
end