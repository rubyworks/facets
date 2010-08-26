require 'facets/file/create'
require 'test/unit'
#require 'tempfile'

class Tets_File_Create < Test::Unit::TestCase

   class MockFile < ::File
     def self.open( fname, mode, &blk )
       blk.call(self)
     end
     def self.read( fname=nil )
       @mock_content.clone
     end
     def self.write( str )
       @mock_content = str
     end
     def self.<<( str )
       (@mock_content ||="") << str
     end
   end

   def test_create
     f = "not-a-real-file.txt"
     t = 'This is a test!'
     MockFile.create( f, t )
     s = MockFile.read( f )
     assert_equal( t, s )
   end

end

