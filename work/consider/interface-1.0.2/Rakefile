require 'rake'
require 'rake/testtask'
require 'rbconfig'
include Config

desc 'Install the interface library (non-gem)'
task :install do
   sitelibdir = CONFIG["sitelibdir"]
   file = "lib/interface.rb"
   FileUtils.cp(file, sitelibdir, :verbose => true)
end

task :gem do
   spec = eval(IO.read('interface.gemspec'))
   Gem::Builder.new(spec).build
end

task :install_gem => [:gem] do
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

desc 'Run the example_instance.rb sample program'
task :example_instance do
   ruby '-Ilib examples/example_instance.rb'
end

desc 'Run the example_interface.rb sample program'
task :example_interface do
   ruby '-Ilib examples/example_interface.rb'
end

desc 'Run the example_sub.rb sample program'
task :example_sub do
   ruby '-Ilib examples/example_sub.rb'
end

desc 'Run the example_unrequire.rb sample program'
task :example_unrequire do
   ruby '-Ilib examples/example_unrequire.rb'
end

Rake::TestTask.new do |t|
   t.verbose = true
   t.warning = true
end
