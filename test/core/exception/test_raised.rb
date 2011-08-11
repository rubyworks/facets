covers 'facets/exception/raised'

test_case Exception do

  class_method :raised? do

    test do
      NameError.raised? do
        supercalafragalistic
      end
    end

  end

end
