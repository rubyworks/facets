require 'facets/array/standard_deviation'

test_case Array do
  method :standard_deviation do
    test 'Empty array returns nil' do
      [].standard_deviation.assert == nil
    end

    test 'Calculate standard_deviation of array of numerical values' do
      [1, 2, 3].standard_deviation.assert == 0.816496580927726
      [96, 35, 72, 30, 75, 33, 68, 13, 49, 71].standard_deviation.assert == 24.69331893448104
      [36, -67, -17, 85, -46, -64, -23, -13, 89, -47].standard_deviation.assert == 54.67183918618432
      [60.7829, 31.2622, 20.626, 78.8907, 61.5328].standard_deviation.assert == 21.428815505053002
    end
  end
end


