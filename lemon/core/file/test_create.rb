require File.dirname(__FILE__) + '/helpers/mockfile'

Covers 'facets/file/create'

TestCase File do

  MetaUnit :create do
    f = "not-a-real-file.txt"
    t = 'This is a test!'
    MockFile.create(f, t)
    s = MockFile.read(f)
    s.assert == t
  end

end

