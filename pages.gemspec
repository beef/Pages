# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pages}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve England"]
  s.date = %q{2009-08-04}
  s.email = %q{steve@wearebeef.co.uk}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/admin/pages_controller.rb",
     "app/controllers/pages_controller.rb",
     "app/helpers/pages_helper.rb",
     "app/models/page.rb",
     "app/views/admin/pages/_page.html.erb",
     "app/views/admin/pages/feature.html.erb",
     "app/views/admin/pages/index.html.erb",
     "app/views/admin/pages/preview.rjs",
     "app/views/admin/pages/show.html.erb",
     "config/routes.rb",
     "generators/page_tempate/page_template_generator.rb",
     "generators/page_tempate/templates/default.html.erb",
     "generators/pages_migration/pages_migration_generator.rb",
     "generators/pages_migration/templates/migration.rb",
     "lib/pages.rb",
     "pages.gemspec",
     "test/pages_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/stengland/pages}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Pages engine}
  s.test_files = [
    "test/pages_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
