covers 'facets/exception/suppress'

tests Exception do

  meta :suppress do

    NameError.suppress do
      supercalafragalistic
    end

  end

end

