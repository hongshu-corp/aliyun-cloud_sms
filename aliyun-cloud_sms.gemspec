# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aliyun/cloud_sms/version'

Gem::Specification.new do |spec|
  spec.name          = "aliyun-cloud_sms"
  spec.version       = Aliyun::CloudSms::VERSION
  spec.authors       = ["Jeremy Cui"]
  spec.email         = ["tsuijy@gmail.com"]

  spec.summary       = %q{Aliyun SMS service gem.}
  spec.description   = %q{Send short message via aliyun cloud service.}
  spec.homepage      = "https://github.com/jerecui/aliyun-cloud_sms"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "uuid", ">=2.0", "<6.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
