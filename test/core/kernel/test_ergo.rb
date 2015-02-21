covers 'facets/kernel/ergo'

test_case Kernel do

  method :ergo do

    test do
      "a".ergo.upcase.assert == "A"
      nil.ergo.foobar.assert == nil

    end

    test do
      "a".ergo { |o| o.upcase }.assert == "A"
      nil.ergo { |o| o.foobar }.assert == nil
    end

  end

end

test_case NilClass do

  method :ergo do

    test do
      "a".ergo { |o| o.upcase }.assert   == "A"
      nil.ergo { |o| o.bar }.assert      == nil
      nil.ergo.ergo { |o| o.bar }.assert == nil
    end

  end

end
