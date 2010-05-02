require 'facets/dir/recurse'
require 'ae/legacy'
require 'fileutils'
require 'tmpdir'

Case Dir do

   RECURSE_TESTDIR = File.join(Dir.tmpdir, 'facets', 'dir', 'recurse', Time.now.usec.to_s)
   RECURSE_DIRS  = %w{A A/B}
   RECURSE_FILES = %w{A.txt A/B.txt A/B/C.txt}

   def recurse_setup
     RECURSE_DIRS.each do |x|
       FileUtils.mkdir_p(File.join(RECURSE_TESTDIR, x))
     end
     RECURSE_FILES.each do |x|
       File.open(File.join(RECURSE_TESTDIR, x), 'w'){ |f| f << "SPINICH" }
     end
   end

   def recurse_teardown
     FileUtils.rm_r(RECURSE_TESTDIR)
   end

   Unit :recurse do
     Dir.chdir RECURSE_TESTDIR do
       rs = (RECURSE_DIRS + RECURSE_FILES).sort
       fs = Dir.recurse.sort
       assert_equal( rs, fs, Dir.pwd  )
     end
   end

   Unit :ls_r do
     Dir.chdir RECURSE_TESTDIR do
       rs = (RECURSE_DIRS + RECURSE_FILES).sort
       fs = Dir.ls_r.sort
       assert_equal( rs, fs, Dir.pwd  )
     end
   end

end

