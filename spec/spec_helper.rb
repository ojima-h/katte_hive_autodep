require 'bundler/setup'

Bundler.setup

APP_PATH = File.expand_path("../", __FILE__)
ENV["KATTE_MODE"] = 'test'

require 'katte'
require 'katte_hive_autodep'
