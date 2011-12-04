# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mime-types}
  s.version = "1.17.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Austin Ziegler}]
  s.date = %q{2011-10-26}
  s.description = %q{This library allows for the identification of a file's likely MIME content
type. This is release 1.17.2. The identification of MIME content type is based
on a file's filename extensions.

MIME::Types for Ruby originally based on and synchronized with MIME::Types for
Perl by Mark Overmeer, copyright 2001 - 2009. As of version 1.15, the data
format for the MIME::Type list has changed and the synchronization will no
longer happen.

Homepage::  http://mime-types.rubyforge.org/
GitHub::    http://github.com/halostatue/mime-types/
Copyright:: 2002 - 2011, Austin Ziegler
            Based in part on prior work copyright Mark Overmeer

:include: License.rdoc}
  s.email = [%q{austin@rubyforge.org}]
  s.extra_rdoc_files = [%q{Manifest.txt}, %q{type-lists/application.txt}, %q{type-lists/audio.txt}, %q{type-lists/image.txt}, %q{type-lists/message.txt}, %q{type-lists/model.txt}, %q{type-lists/multipart.txt}, %q{type-lists/text.txt}, %q{type-lists/video.txt}, %q{History.rdoc}, %q{License.rdoc}, %q{README.rdoc}]
  s.files = [%q{Manifest.txt}, %q{type-lists/application.txt}, %q{type-lists/audio.txt}, %q{type-lists/image.txt}, %q{type-lists/message.txt}, %q{type-lists/model.txt}, %q{type-lists/multipart.txt}, %q{type-lists/text.txt}, %q{type-lists/video.txt}, %q{History.rdoc}, %q{License.rdoc}, %q{README.rdoc}]
  s.homepage = %q{http://mime-types.rubyforge.org/}
  s.rdoc_options = [%q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{mime-types}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{This library allows for the identification of a file's likely MIME content type}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<minitest>, [">= 2.6.2"])
      s.add_development_dependency(%q<nokogiri>, ["~> 1.5"])
      s.add_development_dependency(%q<minitest>, ["~> 2.0"])
      s.add_development_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-gemspec>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-git>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-seattlerb>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe>, ["~> 2.12"])
    else
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<minitest>, [">= 2.6.2"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5"])
      s.add_dependency(%q<minitest>, ["~> 2.0"])
      s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_dependency(%q<hoe-gemspec>, ["~> 1.0"])
      s.add_dependency(%q<hoe-git>, ["~> 1.0"])
      s.add_dependency(%q<hoe-seattlerb>, ["~> 1.0"])
      s.add_dependency(%q<hoe>, ["~> 2.12"])
    end
  else
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<minitest>, [">= 2.6.2"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5"])
    s.add_dependency(%q<minitest>, ["~> 2.0"])
    s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
    s.add_dependency(%q<hoe-gemspec>, ["~> 1.0"])
    s.add_dependency(%q<hoe-git>, ["~> 1.0"])
    s.add_dependency(%q<hoe-seattlerb>, ["~> 1.0"])
    s.add_dependency(%q<hoe>, ["~> 2.12"])
  end
end
