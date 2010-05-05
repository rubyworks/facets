Covers 'facets/string/align'

Case String do

  Unit :align_right do
    "xxx".align_right(9) == "      xxx"
  end

  Unit :align_left do
    "xxx".align_left(9).assert == "xxx      "
  end

  Unit :align_center do
    "xxx".align_center(9).assert == "   xxx   "
  end

end

