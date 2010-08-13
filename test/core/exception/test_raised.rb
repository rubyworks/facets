covers 'facets/exception/raised'

tests Exception do

  metaunit :raised? do

    NameError.raised? do
      supercalafragalistic
    end

  end

end
