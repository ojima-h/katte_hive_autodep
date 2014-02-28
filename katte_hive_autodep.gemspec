# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'katte_hive_autodep/version'

Gem::Specification.new do |spec|
  spec.name          = "katte_hive_autodep"
  spec.version       = KatteHiveAutodep::VERSION
  spec.authors       = ["Hikaru Ojima"]
  spec.email         = ["hikaru.ojima@mixi.co.jp"]
  spec.summary       = "hive dependency parser wrappe for katte"
  spec.description   = "hive dependency parser wrappe for katte"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z lib/`.split("\x0").tap {|files|
    files << "Readme.md"
    files << "LICENSE.txt"
    files << "lib/ext/hive-dependency-parser.jar"
    files << "lib/ext/env.sh"
  }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "katte"
end
