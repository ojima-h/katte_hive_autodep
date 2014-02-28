require "bundler/gem_tasks"

namespace :hdp do
  desc "install hive-dependency-parser"
  task :install => [:build, "lib/ext"] do
    cp("ext/hive-dependency-parser/build/libs/hive-dependency-parser-1.0.jar",
       "lib/ext/hive-dependency-parser.jar", :verbose => true)
    cp("ext/hive-dependency-parser/bin/ext/env.sh",
       "lib/ext/env.sh", :verbose => true)
  end
  directory "lib/ext"

  task :debug_install => :install do
    jars = IO.pipe do |r, w|
      system("cd ext/hive-dependency-parser && gradle listJars -q", :out => w)
      w.close
      "CLASSPATH=" + r.to_a.map(&:chomp).join(":")
    end

    File.open("lib/ext/env-debug.sh", 'w') {|f| f.write jars}
  end

  desc "build hive-dependency-parser"
  task :build do
    sh("cd ext/hive-dependency-parser && gradle jar")
  end

  desc "clean hive-dependency-parser"
  task :clean do
    sh("cd ext/hive-dependency-parser && gradle clean")
  end
end
