covers 'facets/dir/ascend'

tests Dir do

   test_directory = 'test/core/dir'

   metaunit :descend do
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

