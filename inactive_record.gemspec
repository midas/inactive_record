# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{inactive_record}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["C. Jason Harrelson"]
  s.date = %q{2009-06-24}
  s.description = %q{InactiveRecord gives you many of the features you know and love from ActiveRecord without the need for a backing database table.}
  s.email = ["cjharrelson@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "inactive_record.gemspec", "lib/inactive_record.rb", "lib/inactive_record/base.rb", "script/console", "script/destroy", "script/generate", "spec/inactive_record/base_spec.rb", "spec/inactive_record_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/midas/inactive_record/tree/master}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{inactive_record}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{InactiveRecord gives you many of the features you know and love from ActiveRecord without the need for a backing database table.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_development_dependency(%q<activerecord>, [">= 2.2.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_dependency(%q<activerecord>, [">= 2.2.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.3.0"])
    s.add_dependency(%q<activerecord>, [">= 2.2.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
