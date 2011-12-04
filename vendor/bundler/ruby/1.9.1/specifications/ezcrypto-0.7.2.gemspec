# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ezcrypto}
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Pelle Braendgaard}]
  s.date = %q{2009-03-10}
  s.description = %q{Makes it easier and safer to write crypto code.}
  s.email = %q{pelle@stakeventures.com}
  s.extra_rdoc_files = [%q{CHANGELOG}, %q{README.rdoc}, %q{README_ACTIVE_CRYPTO}, %q{README_DIGITAL_SIGNATURES}]
  s.files = [%q{CHANGELOG}, %q{README.rdoc}, %q{README_ACTIVE_CRYPTO}, %q{README_DIGITAL_SIGNATURES}]
  s.homepage = %q{http://ezcrypto.rubyforge.org}
  s.require_paths = [%q{lib}]
  s.requirements = [%q{none}]
  s.rubyforge_project = %q{ezcrypto}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Simplified encryption library.}

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
