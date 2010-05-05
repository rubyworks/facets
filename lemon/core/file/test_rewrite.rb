Covers 'facets/file/rewrite'

require File.dirname(__FILE__) + '/test_helper'

Case File do

   MetaUnit :rewrite do
     f = "not-a-real-file.txt"
     t = 'This is a test!'
     MockFile.write( t )
     MockFile.rewrite(f) { |s| s.reverse }
     s = MockFile.read(f)
     s.assert == t.reverse
   end

end

