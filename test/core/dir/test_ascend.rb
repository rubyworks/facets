covers 'facets/dir/ascend'

tests Dir do

   test_directory = 'test/core/dir'

   metaunit :ascend do
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

   metaunit :ascend => "exclude current" do
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

