
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taxes/version'

Gem::Specification.new do |spec|
  spec.name     = 'taxes'
  spec.version  = Taxes::VERSION
  spec.authors  = ['Mickael Pham']
  spec.email    = ['mickael.pham@protonmail.com']
  spec.summary  = 'Bracketed Tax Engine'
  spec.homepage = 'https://framagit.org/anotherdev/taxes'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'reek',    '~> 4.8'
  spec.add_development_dependency 'rspec',   '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.55'
end
