covers 'facets/dir/recurse'

tests Dir do

   metaunit :recurse do
     r = Dir.recurse('test')
     r.assert.include?('test/core/dir')
     r.assert.include?('test/core/dir/test_recurse.rb')
   end

   metaunit :ls_r do
     r = Dir.ls_r('test')
     r.assert.include?('test/core/dir')
     r.assert.include?('test/core/dir/test_recurse.rb')
   end

end

