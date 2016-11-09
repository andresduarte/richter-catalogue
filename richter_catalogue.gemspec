# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'richter_catalogue/version'

Gem::Specification.new do |spec|
  spec.name          = "richter_catalogue"
  spec.version       = RichterCatalogue::VERSION
  spec.authors       = ["andresduarte"]
  spec.email         = ["andresduarte010@gmail.com"]

  spec.summary       = %q{CLI gem for searching through Gerhard Richter's Catalogue by year or by subject}
  spec.description   = %q{richter_catalogue allows users to the search through an abridged version of Gerhard Richter's Painting Catalogue either by the painting's subject, the year in which it was conceived, or directly by its name.}
  spec.homepage      = "https://github.com/andresduarte/richter-catalogue"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", '>= 0'

  spec.add_runtime_dependency "nokogiri", '>= 0'
end
