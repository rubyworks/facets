covers 'facets/symbol/chomp'

test_case Symbol do

  method :chomp do

    test do
      :ab.chomp(:b).assert == :a
    end

  end

  method :lchomp do

    test do
     :ab.lchomp(:a).assert == :b
    end

  end

end

