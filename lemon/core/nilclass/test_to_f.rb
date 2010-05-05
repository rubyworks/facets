Covers 'facets/nilclass/to_f'

Case NilClass do

  Unit :to_f do
    nil.to_f.assert == 0
  end

end

