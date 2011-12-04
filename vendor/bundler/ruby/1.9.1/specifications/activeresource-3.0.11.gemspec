# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{activeresource}
  s.version = "3.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{David Heinemeier Hansson}]
  s.date = %q{2011-11-18}
  s.description = %q{REST on Rails. Wrap your RESTful web app with Ruby classes and work with them like Active Record models.}
  s.email = %q{david@loudthinking.com}
  s.extra_rdoc_files = [%q{README.rdoc}]
  s.files = [%q{README.rdoc}]
  s.homepage = %q{http://www.rubyonrails.org}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{activeresource}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{REST modeling framework (part of Rails).}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["= 3.0.11"])
      s.add_runtime_dependency(%q<activemodel>, ["= 3.0.11"])
    else
      s.add_dependency(%q<activesupport>, ["= 3.0.11"])
      s.add_dependency(%q<activemodel>, ["= 3.0.11"])
    end
  else
    s.add_dependency(%q<activesupport>, ["= 3.0.11"])
    s.add_dependency(%q<activemodel>, ["= 3.0.11"])
  end
end
