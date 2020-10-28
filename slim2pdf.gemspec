# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slim2pdf/version'

Gem::Specification.new do |spec|
  spec.name          = "slim2pdf"
  spec.version       = Slim2pdf::VERSION
  spec.authors       = ["Piotr Macuk"]
  spec.email         = ["piotr@macuk.pl"]
  spec.description   = %q{Slim2pdf renders slim template with data hash and save the results as pdf file.}
  spec.summary       = %q{Slim template to pdf file conversion tool.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"

  spec.add_dependency 'slim', '~> 4.0'
  spec.add_dependency "wkhtmltopdf-binary", '~> 0.12'
end
