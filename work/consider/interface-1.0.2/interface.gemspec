require 'rubygems'

Gem::Specification.new do |gem|
   gem.name      = 'interface'
   gem.version   = '1.0.2'
   gem.author    = 'Daniel J. Berger'
   gem.license   = 'Artistic 2.0'
   gem.email     = 'djberg96@gmail.com'
   gem.homepage  = 'http://www.rubyforge.org/projects/shards'
   gem.summary   = 'Java style interfaces for Ruby'
   gem.test_file = 'test/test_interface.rb'
   gem.has_rdoc  = true
   gem.files     = Dir['**/*'].reject{ |f| f.include?('CVS') }

   gem.extra_rdoc_files  = ['README', 'CHANGES', 'MANIFEST']
   gem.rubyforge_project = 'shards'

   gem.add_development_dependency('test-unit', '>= 2.0.3')

   gem.description = <<-EOF
      The interface library implements Java style interfaces for Ruby.
      It lets you define a set a methods that must be defined in the
      including class or module, or an error is raised.
   EOF
end
