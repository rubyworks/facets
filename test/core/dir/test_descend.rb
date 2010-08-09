Covers 'facets/dir/ascend'

require 'tmpdir'

Case Dir do

   test_directory = File.join(Dir.tmpdir, 'facets', 'dir', 'descend', Time.now.usec.to_s)

   Unit :descend do
     c = []
     Dir.descend(test_directory) do |path|
       c << path
     end
     rdir = test_directory
     c.reverse_each do |d|
       d.assert == rdir
       rdir = File.dirname(rdir)
     end
   end

end

