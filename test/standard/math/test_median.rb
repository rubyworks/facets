covers 'facets/math/median'

test_case Math do

  class_method :median do
    test "fractional" do
      r = Math.median [1, 2, 3, 3, 6, 11, 20, 20]
      r.assert == 4.5
    end

    test "whole value" do
      r = Math.median [1, 2, 4, 6, 8]
      r.assert == 4
    end
  end

end
