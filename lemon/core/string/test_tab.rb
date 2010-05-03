require 'facets/string/tab'

Case String do

  # TODO: Need to expand on #tab tests.
  Unit :tab do
    a = "xyz".tab(4)
    a[0..3].assert == '    '
  end

end

