require 'facets/file/create'
require File.dirname(__FILE__) + '/test_helper'

Case File do

   Unit :create do
     f = "not-a-real-file.txt"
     t = 'This is a test!'
     MockFile.create( f, t )
     s = MockFile.read( f )
     s.assert == t
   end

end

