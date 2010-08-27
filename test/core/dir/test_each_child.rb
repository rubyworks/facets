covers 'facets/dir/each_child'

tests Dir do

   test_directory = 'test'

   unit :each_child do
     c = []
     d = Dir.new(test_directory)
     d.each_child do |path|
       c << path
     end
     d.close
     c.sort.assert == ['core', 'more', 'tour']
   end

end

