Covers 'facets/dir/ascend'

require 'tmpdir'

Case Dir do

   #DIRS  = %w{A A/B}
   #FILES = %w{A.txt A/B.txt A/B/C.txt}

   test_directory = File.join(Dir.tmpdir, 'facets', 'dir', 'ascend', Time.now.usec.to_s)

   Unit :ascend do
     c = []
     Dir.ascend(test_directory) do |path|
       c << path
     end
     rdir = test_directory
     c.each do |d|
       d.assert == rdir
       rdir = File.dirname(rdir)
     end
   end

   Unit :ascend => "exclude current" do
     c = []
     Dir.ascend(test_directory, false) do |path|
       c << path
     end
     rdir = File.dirname(test_directory)
     c.each do |d|
       d.assert == rdir
       rdir = File.dirname(rdir)
     end
   end

end

