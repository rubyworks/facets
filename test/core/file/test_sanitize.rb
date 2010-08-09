Covers 'facets/file/sanitize'

require File.dirname(__FILE__) + '/helpers/mockfile'

Case File do

  # TODO: Write file identity tests.

  MetaUnit :sanitize => "spaces become underscores" do
    MockFile.sanitize('This is a test').assert == "This_is_a_test"
  end

  MetaUnit :sanitize => "Windows-style path dividers" do
    MockFile.sanitize('This\is\test').assert == "test"
  end

  MetaUnit :sanitize => "Unix-style path dividers" do
    MockFile.sanitize('This/is/test').assert == "test"
  end

  MetaUnit :sanitize => "non-word characters" do
    MockFile.sanitize('This/te#$#@!st').assert == "te_____st"
  end

  MetaUnit :sanitize => "initial dot" do
    MockFile.sanitize('.').assert == "_."
    MockFile.sanitize('....').assert == "_...."
  end

end

# class TestFileRead < Test::Unit::TestCase
#
#
#   class MockFile < ::File
#     def open( fname, mode, &blk )
#       blk.call(self)
#     end
#     def read( fname=nil )
#       @mock_content.clone
#     end
#     def write( str )
#       @mock_content = str
#     end
#     def <<( str )
#       (@mock_content ||="") << str
#     end
#   end
#
#   File = MockFile.new
#
#   def test_read_list
#     f = File.write("A\nB\nC")
#     s = File.read_list( f )
#     r = ['A','B','C']
#     assert_equal( r, s )
#   end
#
# end

