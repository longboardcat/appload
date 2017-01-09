# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'appload/version'

Gem::Specification.new do |spec|
  spec.name          = 'appload'
  spec.version       = Appload::VERSION
  spec.authors       = ['James Chang']
  spec.email         = ['jchang@squareup.com']

  spec.summary       = 'Guiding iOS release managers through appstore upload.'
  spec.description   = 'Guiding iOS release managers through appstore upload.'
  spec.homepage      = 'https://github.com/longboardcat/appload'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'awesome_print', '~> 1.6'
  spec.add_dependency 'colored', '~> 1.2'
  spec.add_dependency 'deliver', '~> 1.10'
  spec.add_dependency 'pliney', '~> 0.0.4'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.38.0'
end
