covers 'facets/string/align'

testcase String do

  unit :align do
    "xxx".align(:right, 9) == "      xxx"
    "xxx".align(:left, 9).assert == "xxx      "
    "xxx".align(:center, 9).assert == "   xxx   "
  end

  unit :align_right do
    "xxx".align_right(9) == "      xxx"
  end

  unit :align_left do
    "xxx".align_left(9).assert == "xxx      "
  end

  unit :align_center do
    "xxx".align_center(9).assert == "   xxx   "
  end

end

