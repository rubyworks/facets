require 'tempfile'
require 'fileutils'

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

