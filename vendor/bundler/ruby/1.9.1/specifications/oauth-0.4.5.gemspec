# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{oauth}
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Pelle Braendgaard}, %q{Blaine Cook}, %q{Larry Halff}, %q{Jesse Clark}, %q{Jon Crosby}, %q{Seth Fitzsimmons}, %q{Matt Sanford}, %q{Aaron Quint}]
  s.date = %q{2011-06-25}
  s.description = %q{OAuth Core Ruby implementation}
  s.email = %q{oauth-ruby@googlegroups.com}
  s.executables = [%q{oauth}]
  s.extra_rdoc_files = [%q{LICENSE}, %q{README.rdoc}, %q{TODO}]
  s.files = [%q{bin/oauth}, %q{LICENSE}, %q{README.rdoc}, %q{TODO}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{oauth}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{OAuth Core Ruby implementation}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<actionpack>, [">= 2.3.5"])
      s.add_development_dependency(%q<rack>, [">= 1.0.0"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_development_dependency(%q<typhoeus>, [">= 0.1.13"])
      s.add_development_dependency(%q<em-http-request>, [">= 0.2.10"])
      s.add_development_dependency(%q<curb>, [">= 0.6.6.0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<actionpack>, [">= 2.3.5"])
      s.add_dependency(%q<rack>, [">= 1.0.0"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_dependency(%q<typhoeus>, [">= 0.1.13"])
      s.add_dependency(%q<em-http-request>, [">= 0.2.10"])
      s.add_dependency(%q<curb>, [">= 0.6.6.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<actionpack>, [">= 2.3.5"])
    s.add_dependency(%q<rack>, [">= 1.0.0"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
    s.add_dependency(%q<typhoeus>, [">= 0.1.13"])
    s.add_dependency(%q<em-http-request>, [">= 0.2.10"])
    s.add_dependency(%q<curb>, [">= 0.6.6.0"])
  end
end
