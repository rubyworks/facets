covers 'facets/hash/new_with'

test_case Hash do

  class_method :new_with do

    test do
      h = Hash.new_with{0}

      h[:ab].assert == 0
      h[100].assert == 0
      h["a"].assert == 0
    end

  end

end
