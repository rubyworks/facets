require 'facets/file/write'
require 'test/unit'
require 'tempfile'

class TC_File_Writelines < Test::Unit::TestCase

  def setup
    tmp_dir = Dir::tmpdir # ENV["TMP"] || ENV["TEMP"] || "/tmp"
    raise "Can't find temporary directory" unless File.directory?(tmp_dir)
    @path = File.join(tmp_dir, "ruby_io_test")
  end

  # Test File.writelines
  def test_file_writelines
    data_in = %w[one two three four five]
    File.writelines(@path, data_in)
    data_out = File.readlines(@path)     # This is standard class method.
    assert_equal(data_in, data_out.map { |l| l.chomp })
  end

end

