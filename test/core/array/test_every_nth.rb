covers 'facets/array/every_nth.rb'

test_case Array do

  method :every_nth do

    test do
      a = [:a, :b, :c, :d]
      a.every_nth(1).assert == [:a, :b, :c, :d]
      a.every_nth(2).assert == [:b, :d]
      a.every_nth(3).assert == [:c]
      a.every_nth(5).assert == []
    end

  end

end


