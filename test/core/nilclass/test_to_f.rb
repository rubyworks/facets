covers 'facets/nilclass/to_f'

test_case NilClass do

  method :to_f do

    test do
      nil.to_f.assert == 0
    end

  end

end
