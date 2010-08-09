Covers 'facets/string/tabto'

Case String do

  # TODO: Need to expand tabto tests
  Unit :tabto do
    a = "xyz".tabto(4)
    a[0..3].assert ==  '    '
  end

end

