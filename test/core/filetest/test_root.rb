Covers 'facets/filetest/root'

Case FileTest do

  MetaUnit :root? do
    assert FileTest.root?('/')
  end

end

