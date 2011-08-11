covers 'facets/filetest/root'

test_case FileTest do

  class_method :root? do

    test do
      assert FileTest.root?('/')
    end

  end

end

