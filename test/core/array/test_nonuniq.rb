covers 'facets/array/nonuniq'

test_case Array do

  method :nonuniq do

    test do
      a = [1,1,2,2,3,4,5]
      a.nonuniq.sort.assert == [1,2]
    end

  end

  method :nonuniq! do

    test do
      a = [1,1,2,2,3,4,5]
      a.nonuniq!
      a.sort.assert == [1,2]
    end

  end

end

