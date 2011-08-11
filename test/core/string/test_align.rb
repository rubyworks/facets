covers 'facets/string/align'

test_case String do

  method :align do
    test do
      "xxx".align(:right, 9) == "      xxx"
      "xxx".align(:left, 9).assert == "xxx      "
      "xxx".align(:center, 9).assert == "   xxx   "
    end
  end

  method :align_right do
    test do
      "xxx".align_right(9) == "      xxx"
    end
  end

  method :align_left do
    test do
      "xxx".align_left(9).assert == "xxx      "
    end
  end

  method :align_center do
    test do
      "xxx".align_center(9).assert == "   xxx   "
    end
  end

end

