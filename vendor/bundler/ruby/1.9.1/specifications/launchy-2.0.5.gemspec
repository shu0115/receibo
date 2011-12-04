# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{launchy}
  s.version = "2.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jeremy Hinegardner}]
  s.date = %q{2011-07-29}
  s.description = %q{Launchy is helper class for launching cross-platform applications in a
fire and forget manner.

There are application concepts (browser, email client, etc) that are
common across all platforms, and they may be launched differently on
each platform.  Launchy is here to make a common approach to launching
external application from within ruby programs.
}
  s.email = %q{jeremy@copiousfreetime.org}
  s.executables = [%q{launchy}]
  s.extra_rdoc_files = [%q{HISTORY}, %q{LICENSE}, %q{README}, %q{bin/launchy}]
  s.files = [%q{bin/launchy}, %q{HISTORY}, %q{LICENSE}, %q{README}]
  s.homepage = %q{http://www.copiousfreetime.org/projects/launchy}
  s.rdoc_options = [%q{--main}, %q{README}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{launchy}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Launchy is helper class for launching cross-platform applications in a fire and forget manner.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>, ["~> 2.2.6"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_development_dependency(%q<minitest>, ["~> 2.3.1"])
      s.add_development_dependency(%q<bones>, ["~> 3.7.0"])
      s.add_development_dependency(%q<bones-rcov>, ["~> 1.0.1"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9.9"])
      s.add_development_dependency(%q<spoon>, ["~> 0.0.1"])
      s.add_development_dependency(%q<ffi>, ["~> 1.0.9"])
    else
      s.add_dependency(%q<addressable>, ["~> 2.2.6"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<minitest>, ["~> 2.3.1"])
      s.add_dependency(%q<bones>, ["~> 3.7.0"])
      s.add_dependency(%q<bones-rcov>, ["~> 1.0.1"])
      s.add_dependency(%q<rcov>, ["~> 0.9.9"])
      s.add_dependency(%q<spoon>, ["~> 0.0.1"])
      s.add_dependency(%q<ffi>, ["~> 1.0.9"])
    end
  else
    s.add_dependency(%q<addressable>, ["~> 2.2.6"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<minitest>, ["~> 2.3.1"])
    s.add_dependency(%q<bones>, ["~> 3.7.0"])
    s.add_dependency(%q<bones-rcov>, ["~> 1.0.1"])
    s.add_dependency(%q<rcov>, ["~> 0.9.9"])
    s.add_dependency(%q<spoon>, ["~> 0.0.1"])
    s.add_dependency(%q<ffi>, ["~> 1.0.9"])
  end
end
