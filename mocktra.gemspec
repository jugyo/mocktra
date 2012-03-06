# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mocktra/version"

Gem::Specification.new do |s|
  s.name        = "mocktra"
  s.version     = Mocktra::VERSION
  s.authors     = ["jugyo"]
  s.email       = ["jugyo.org@gmail.com"]
  s.homepage    = "https://github.com/jugyo/mocktra"
  s.summary     = %q{webmock + sinatra}
  s.description = %q{A webmock DSL using sinatra.}

  s.rubyforge_project = "mocktra"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "webmock"
  s.add_runtime_dependency "webmock", "~> 1.8"
  s.add_runtime_dependency "sinatra", "~> 1.3"
end
