covers 'facets/enumerator/fx'

test_case Enumerator do

  method :fx do

    test do
      e = [1,2,3].to_enum
      r = e.fx + 2
      r.assert == [3,4,5]
    end

  end

end

