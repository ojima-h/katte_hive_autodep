require "bundler/gem_tasks"

namespace :hdp do
  desc "install hive-dependency-parser"
  task :install => [:build, "lib/ext"] do
    cp("ext/hive-dependency-parser/build/libs/hive-dependency-parser-1.0.jar",
       "lib/ext/hive-dependency-parser.jar", :verbose => true)
  end
  directory "lib/ext"

  desc "build hive-dependency-parser"
  task :build do
    sh("cd ext/hive-dependency-parser && gradle jar")
  end

  desc "clean hive-dependency-parser"
  task :clean do
    sh("cd ext/hive-dependency-parser && gradle clean")
  end
end
