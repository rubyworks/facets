Covers 'facets/file/split_all'

require File.dirname(__FILE__) + '/test_helper'

Case File do

  MetaUnit :split_all do
    fp = "this/is/test"
    MockFile.split_all(fp).assert == ['this', 'is', 'test']
  end

end
