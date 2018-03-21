# -*- encoding: utf-8 -*-
# stub: minruby 1.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "minruby"
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Yusuke Endoh"]
  s.bindir = "exe"
  s.date = "2016-12-03"
  s.description = "This library provides some helper modules to implement a toy Ruby implementation.  This is created for a series of articles, \"Ruby de manabu Ruby (Learning Ruby by implementing Ruby)\", in ASCII.jp"
  s.email = ["mame@ruby-lang.org"]
  s.homepage = "http://github.com/mame/minruby/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "A helper library for \"Ruby de manabu Ruby\""

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.13"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.13"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.13"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
  end
end
