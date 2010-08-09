require 'facets/dir/multiglob'
require 'test/unit'
require 'fileutils'
require 'tmpdir'

class TC_Dir_Multiglob < Test::Unit::TestCase

   DIRS  = %w{A A/B}
   FILES = %w{A.txt A/B.txt A/B/C.txt}

   def setup
     @location = File.join(Dir.tmpdir, self.class.name, Time.now.usec.to_s)
     DIRS.each do |x|
       FileUtils.mkdir_p(File.join(@location, x))
     end
     FILES.each do |x|
       File.open(File.join(@location, x), 'w'){ |f| f << "SPINICH" }
     end
   end

   def teardown
     FileUtils.rm_r(@location)
   end

   def test_multiglob
     Dir.chdir @location do
       rs = %w{A A.txt}
       fs = Dir.multiglob('*').sort
       assert_equal( rs, fs, Dir.pwd  )
     end
   end

   def test_multiglob_r
     Dir.chdir @location do
       rs = (DIRS + FILES).sort
       fs = Dir.multiglob_r('*').sort
       assert_equal( rs, fs, Dir.pwd  )
     end
   end

end

