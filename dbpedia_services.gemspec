# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbpedia_search/version'

Gem::Specification.new do |spec|
  spec.name          = "dbpedia_search"
  spec.version       = DbpediaSearch::VERSION
  spec.authors       = ["rushilagr"]
  spec.email         = ["rushil.agrawal@gmail.com"]

  spec.summary       = %q{todo Write a short summary, because Rubygems requires one.}
  spec.description   = %q{todo Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/rushilagr/dbpedia-services-client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "todo Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "dbpedia", "~> 0.0.1"
  spec.add_dependency "httparty"
  spec.add_dependency 'httplog'
  spec.add_dependency 'dry-configurable'

end
