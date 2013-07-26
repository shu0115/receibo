# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "builder"
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Weirich"]
  s.autorequire = "builder"
  s.date = "2007-06-15"
  s.description = "Builder provides a number of builder objects that make creating structured data simple to do.  Currently the following builder objects are supported:  * XML Markup * XML Events"
  s.email = "jim@weirichhouse.org"
  s.extra_rdoc_files = ["CHANGES", "Rakefile", "README", "doc/releases/builder-1.2.4.rdoc", "doc/releases/builder-2.0.0.rdoc", "doc/releases/builder-2.1.1.rdoc"]
  s.files = ["CHANGES", "Rakefile", "README", "doc/releases/builder-1.2.4.rdoc", "doc/releases/builder-2.0.0.rdoc", "doc/releases/builder-2.1.1.rdoc"]
  s.homepage = "http://onestepback.org"
  s.rdoc_options = ["--title", "Builder -- Easy XML Building", "--main", "README", "--line-numbers"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = "2.0.3"
  s.summary = "Builders for MarkUp."
end
