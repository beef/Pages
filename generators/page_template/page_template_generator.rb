class PageTemplateGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|
      m.directory(File.join('app', 'views', 'pages', 'templates')) 
      
      m.file('default.html.erb', File.join('app', 'views', 'pages', 'templates', "#{name}.html.erb"))
    end
  end
  
end