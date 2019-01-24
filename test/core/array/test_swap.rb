covers "facets/array/swap"

test_case Array do
  method :swap do
    test do
      a = [1, 2, 3]
      b = a.swap(1, 2)
      c = [1, 3, 2]
      b.assert == c
      b.assert.__id__ != a.__id__
    end
  end

  method :swap! do
    test do
      a = [1, 2, 3]
      b = a.swap!(1, 2)
      c = [1, 3, 2]
      b.assert == c
      b.assert.__id__ == a.__id__
    end
  end
end
