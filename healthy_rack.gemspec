
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'healthy_rack/version'

Gem::Specification.new do |spec|
  spec.name          = 'healthy_rack'
  spec.version       = HealthyRack::VERSION
  spec.authors       = ['Konstantin Nizhegorodov']
  spec.email         = ['k.nizhegorodov@gmail.com']

  spec.summary       = 'Rack middleware for checking health status.'
  spec.description   = "Checks that application's database, sidekiq etc are responding."
  spec.homepage      = 'https://github.com/konstantinn/healthy_rack'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry-byebug', '~> 3.6'
  spec.add_development_dependency 'rack-test', '~> 0.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.53'
end
