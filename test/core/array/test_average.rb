require 'facets/array/average'

test_case Array do
  method :average do
    test 'Empty array returns nil' do
      [].average.assert == nil
    end

    test 'Calculate average of array of numerical values' do
      [1, 2, 3].average.assert == 2
      [96, 35, 72, 30, 75, 33, 68, 13, 49, 71].average.assert == 54.2
      [36, -67, -17, 85, -46, -64, -23, -13, 89, -47].average.assert == -6.7
      [60.7829, 31.2622, 20.626, 78.8907, 61.5328].average.assert == 50.61892
    end
  end
end
