require 'rake'
require 'rake/testtask'

desc "Cleanup .test-result files if present"
task :clean do
   rm_rf '.test-result' if File.exists?('.test-result')

   Dir.foreach(Dir.pwd){ |file|
      if File.directory?(file)
         Dir.chdir(file){
            rm_rf '.test-result' if File.exists?('.test-result')
         }
      end
   }
end

desc "Install the file-find library (non-gem)"
task :install do
   dest = File.join(Config::CONFIG['sitelibdir'], 'file')
   Dir.mkdir(dest) unless File.exists? dest
   cp 'lib/file/find.rb', dest, :verbose => true
end

desc "Install the file-find library as a gem"
task :install_gem do
   ruby 'file-find.gemspec'
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

desc 'Create a gem'
task :gem do
   spec = eval(IO.read('file-find.gemspec'))
   if RUBY_PLATFORM.match('java')
      spec.platform = Gem::Platform::CURRENT
   else
      spec.add_dependency('sys-admin', '>= 1.5.2')
   end   

   Gem::Builder.new(spec).build
end

Rake::TestTask.new do |t|
   t.warning = true
   t.verbose = true
end
