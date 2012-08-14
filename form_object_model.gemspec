# -*- encoding: utf-8 -*-
require File.expand_path('../lib/form_object_model/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sean Geoghegan"]
  gem.email         = ["sean@seangeo.me"]
  gem.description   = %q{An OO form testing helper that makes Capayaba-based form testing easy.}
  gem.summary       = %q{An OO form testing helper that makes Capayaba-based form testing easy.}
  gem.homepage      = "https://github.com/reinteractive-open/form-object-model"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "form_object_model"
  gem.require_paths = ["lib"]
  gem.version       = FormObjectModel::VERSION

  gem.add_dependency('capybara', '~> 1.1')

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('rake')
end

