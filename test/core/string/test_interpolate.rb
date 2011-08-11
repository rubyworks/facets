covers 'facets/string/interpolate'

test_case String do

  class_method :interpolate do

    test do
      a = 1
      String.interpolate{ 'this is #{a}' }.assert == 'this is 1'
    end

  end

end


