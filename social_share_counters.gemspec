# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'social_share_counters/version'

Gem::Specification.new do |spec|

  spec.name          = "social_share_counters"
  spec.version       = SocialShareCounters::VERSION
  spec.authors       = ["Ivan Pilyaev"]
  spec.email         = ["piliaiev@gmail.com"]

  spec.summary       = %q{Simple counter for social share stats.}
  spec.description   = %q{Simple counter for social share stats.}
  spec.homepage      = "https://github.com/dancingbytes/social_share_counters"

  spec.license       = "BSD"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency "oj", '~> 2.13'

end
