# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'config_loader/version'

Gem::Specification.new do |spec|
  spec.name          = 'config_loader'
  spec.version       = ConfigLoader::VERSION
  spec.authors       = ['Indrek Juhkam']
  spec.email         = ['indrek@salemove.com']
  spec.description   = %q{}
  spec.summary       = %q{Helps to load config files in SaleMove ecosystem}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
