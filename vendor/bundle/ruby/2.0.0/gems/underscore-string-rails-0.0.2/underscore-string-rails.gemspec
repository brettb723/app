# -*- encoding: utf-8 -*-
require File.expand_path('../lib/underscore-string-rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jaimie van Santen"]
  gem.email         = ["jaimie@jaimievansanten.nl"]
  gem.description   = %q{This includes the underscore string library in your application}
  gem.summary       = %q{asset pipline javascript underscore rails}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "underscore-string-rails"
  gem.require_paths = ["lib"]
  gem.version       = Underscore::String::Rails::VERSION
end
