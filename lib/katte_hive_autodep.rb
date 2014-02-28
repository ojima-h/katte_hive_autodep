require "katte_hive_autodep/version"
require "katte_hive_autodep/resolver"

require "katte"

module KatteHiveAutodep
  Katte::Runner.after(:load_all, &Resolver.method(:call))
end
