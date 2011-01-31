covers 'facets/hash/new_with'

tests Hash do

  meta :new_with do
    h = Hash.new_with{0}

    h[:ab].assert == 0
    h[100].assert == 0
    h["a"].assert == 0
  end

end
