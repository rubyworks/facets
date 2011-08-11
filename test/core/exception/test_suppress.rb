covers 'facets/exception/suppress'

test_case Exception do

  class_method :suppress do

    test do
      NameError.suppress do
        supercalafragalistic
      end
    end

  end

end

