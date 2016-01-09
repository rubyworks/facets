require 'facets/array/variance'

test_case Array do
  method :variance do
    test 'Empty array returns nil' do
      [].variance.assert == nil
    end

    test 'Calculate variance of array of numerical values' do
      [1, 2, 3].variance.assert == 0.6666666666666666
      [96, 35, 72, 30, 75, 33, 68, 13, 49, 71].variance.assert == 609.76
      [36, -67, -17, 85, -46, -64, -23, -13, 89, -47].variance.assert == 2989.0099999999993
      [60.7829, 31.2622, 20.626, 78.8907, 61.5328].variance.assert == 459.1941339495999
    end
  end
end

