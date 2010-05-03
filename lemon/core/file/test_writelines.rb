require 'facets/file/writelines'
require File.dirname(__FILE__) + '/test_helper'

Case File do

  Unit :writelines do
    test_file = File.join(Dir::tmpdir, 'facets', 'file', 'writelines')
    FileUtils.mkdir_p(File.dirname(test_file))

    data_in = %w[one two three four five]

    File.writelines(test_file, data_in)

    data_out = File.readlines(test_file)
    data_out.map{ |l| l.chomp }.assert == data_in
  end

end

