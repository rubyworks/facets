covers 'facets/regexp/to_re'

test_case Regexp do

  method :to_re do

    test do
      r = /0..10/
      r.to_re.assert == r.to_re
    end

  end

  method :to_regexp do

    test do
      r = /0..10/
      r.to_regexp.assert == r
    end

  end

end

