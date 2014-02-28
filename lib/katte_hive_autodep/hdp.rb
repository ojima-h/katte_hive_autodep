require 'json'

module KatteHiveAutodep
  class HDP
    # wrapper class for hive-dependency-parser

    EXT_LIB_ROOT   = File.expand_path("../../ext/", __FILE__)
    ENV_SCRIPT     = File.join(EXT_LIB_ROOT, (ENV["KATTE_MODE"] == 'test' ? "env-debug.sh" : "env.sh"))
    HDP_JAR        = File.join(EXT_LIB_ROOT, "hive-dependency-parser.jar")
    HDP_MAIN_CLASS = "org.mixi.analysis.hive.dependency.parser.Driver"

    def initialize
    end

    def run(file)
      return unless File.file? file

      dependency = IO.pipe do |o_r,o_w|
        ret = system(<<EOF, :out => o_w, :err => "/dev/null")
source #{ENV_SCRIPT}
CLASSPATH=$CLASSPATH:#{HDP_JAR} java -Xmx256m #{HDP_MAIN_CLASS} #{file}
EOF

        return unless ret

        o_w.close
        o_r.to_a.join
      end

      JSON.parse(dependency)
    end
  end
end
