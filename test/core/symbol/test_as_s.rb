covers 'facets/symbol/as_s'

test_case Symbol do

  method :as_s do

    test do
      s = :foo.as_s.sub('f','g')
      s.assert == :goo
    end

  end

end

