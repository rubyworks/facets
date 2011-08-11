covers 'facets/dir/ascend'

test_case Dir do

   test_directory = 'test/core/dir'

   class_method :ascend do

     test do
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

   end

   class_method :ascend do

     test "exclude current" do
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

end

