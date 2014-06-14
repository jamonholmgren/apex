# -*- encoding: utf-8 -*-
require File.expand_path('../lib/apex/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "apex"
  gem.version       = Apex::VERSION
  gem.authors       = ["Jamon Holmgren"]
  gem.email         = ["jamon@clearsightstudio.com"]
  gem.description   = "Apex: the RubyMotion web framework for OS X."
  gem.summary       = "
                        Apex is a RubyMotion web framework for OS X. It uses
                        GCDWebServer under the hood and provides a Sinatra-like
                        router and DSL.
                      "
  gem.homepage      = "https://github.com/clearsightstudio/apex"
  gem.license       = "MIT"

  gem.files         = Dir.glob("lib/**/*.rb")
  gem.files         << "README.md"

  gem.test_files    = Dir.glob("spec/**/*.rb")
  gem.require_paths = ["lib"]

  gem.add_dependency("motion-cocoapods", ">= 1.5.0")
  gem.add_development_dependency("webstub", "~> 1.0")
  gem.add_development_dependency("motion-stump", "~> 0.3")
  gem.add_development_dependency("motion-redgreen", "~> 0.1")
  gem.add_development_dependency("rake", ">= 10.0")
end
