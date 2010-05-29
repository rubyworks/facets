Covers 'facets/file/write'

require File.dirname(__FILE__) + '/helpers/mockfile'

Case File do

  MetaUnit :write do
    test_file = File.join(Dir::tmpdir, 'facets', 'file', 'write')
    FileUtils.mkdir_p(File.dirname(test_file))

    data_in = "Test data\n"

    nbytes = File.write(test_file, data_in)
    data_out = File.read(test_file)

    data_out.assert == data_in
    data_out.size.assert == nbytes
  end

end

