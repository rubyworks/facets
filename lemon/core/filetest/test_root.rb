require 'facets/filetest/root'

Case FileTest do

  Unit :root do
    assert FileTest.root?('/')
  end

end

