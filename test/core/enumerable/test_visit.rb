covers 'facets/enumerable/visit'

test_case Enumerable do

  method :visit do

    test do
      r = [1, 2, 8..9].visit{ |x| x.succ }
      r.assert == [2, 3, [9, 10]]
    end  

  end

end
