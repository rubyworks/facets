Covers 'facets/dir/recurse'

require 'fileutils'
require 'tmpdir'

Case Dir do

   test_directory = File.join(Dir.tmpdir, 'facets', 'dir', 'recurse', Time.now.usec.to_s)
   recurse_dirs  = %w{A A/B}
   recurse_files = %w{A.txt A/B.txt A/B/C.txt}

   Before :recurse, :ls_r do
     recurse_dirs.each do |x|
       FileUtils.mkdir_p(File.join(test_directory, x))
     end
     recurse_files.each do |x|
       File.open(File.join(test_directory, x), 'w'){ |f| f << "SPINICH" }
     end
   end

   After :recurse, :ls_r do
     FileUtils.rm_r(test_directory)
   end

   Unit :recurse do
     Dir.chdir test_directory do
       x = (recurse_dirs + recurse_files).sort
       r = Dir.recurse.sort
       r.assert == x
     end
   end

   Unit :ls_r do
     Dir.chdir test_directory do
       x = (recurse_dirs + recurse_files).sort
       r = Dir.ls_r.sort
       r.assert == x
     end
   end

end

