covers 'facets/regexp/multiline'

test_case Regexp do

  method :multiline? do

    test do
      re = /x/m
      re.assert.multiline?
    end

    test do
      re = /x/
      re.refute.multiline?
    end

  end

end
