require 'facets/nilclass/to_f'

Case NilClass

  Unit :to_f do
    nil.to_f.assert == 0
  end

end

