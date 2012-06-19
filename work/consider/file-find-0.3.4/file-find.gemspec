require 'rubygems'

Gem::Specification.new do |gem|
   gem.name      = 'file-find'
   gem.version   = '0.3.4'
   gem.author    = 'Daniel Berger'
   gem.license   = 'Artistic 2.0'
   gem.summary   = 'A better way to find files'
   gem.email     = 'djberg96@gmail.com'
   gem.homepage  = 'http://www.rubyforge.org/projects/shards'
   gem.platform  = Gem::Platform::RUBY
   gem.files     = Dir['**/*'].reject{ |f| f.include?('CVS') }
   gem.test_file = 'test/test_file_find.rb'
   gem.has_rdoc  = true

   gem.rubyforge_project = 'shards'
   gem.extra_rdoc_files = ['README', 'CHANGES', 'MANIFEST']

   gem.add_development_dependency('test-unit', '>= 2.0.3')

   gem.description = <<-EOF
      The file-find library provides a better, more object oriented approach
      to finding files. It allows you to find files based on a variety of
      properties, such as access time, size, owner, etc. You can also limit
      directory depth.
   EOF
end
