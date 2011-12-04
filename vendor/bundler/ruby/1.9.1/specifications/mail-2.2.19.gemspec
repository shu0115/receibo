# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mail}
  s.version = "2.2.19"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Mikel Lindsaar}]
  s.date = %q{2011-04-25}
  s.description = %q{A really Ruby Mail handler.}
  s.email = %q{raasdnil@gmail.com}
  s.extra_rdoc_files = [%q{README.rdoc}, %q{CHANGELOG.rdoc}, %q{TODO.rdoc}]
  s.files = [%q{README.rdoc}, %q{CHANGELOG.rdoc}, %q{TODO.rdoc}]
  s.homepage = %q{http://github.com/mikel/mail}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Mail provides a nice Ruby DSL for making, sending and reading emails.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.6"])
      s.add_runtime_dependency(%q<mime-types>, ["~> 1.16"])
      s.add_runtime_dependency(%q<treetop>, ["~> 1.4.8"])
      s.add_runtime_dependency(%q<i18n>, [">= 0.4.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.6"])
      s.add_dependency(%q<mime-types>, ["~> 1.16"])
      s.add_dependency(%q<treetop>, ["~> 1.4.8"])
      s.add_dependency(%q<i18n>, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.6"])
    s.add_dependency(%q<mime-types>, ["~> 1.16"])
    s.add_dependency(%q<treetop>, ["~> 1.4.8"])
    s.add_dependency(%q<i18n>, [">= 0.4.0"])
  end
end
