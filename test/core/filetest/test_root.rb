covers 'facets/filetest/root'

testcase FileTest do

  metaunit :root? do
    assert FileTest.root?('/')
  end

end

