covers 'facets/kernel/ergo'

test_case Kernel do

  method :ergo do

    test do
      "a".ergo.upcase.assert == "A"
      nil.ergo.foobar.assert == nil # test is raising "can't modify frozen NilClass"

    end

    test do
      "a".ergo{ |o| o.upcase }.assert == "A"
      nil.ergo{ |o| o.foobar }.assert == nil # test is raising "can't modify frozen NilClass"
    end

  end

end

test_case NilClass do

  method :ergo do

    test do
      "a".ergo{ |o| o.upcase }.assert == "A"
      nil.ergo{ |o| o.bar }.assert == nil # test is raising "can't modify frozen NilClass"
    end

  end

end
