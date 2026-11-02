covers 'facets/math/percentile'

test_case Math do

  class_method :percentile do
    test do
      a = [1,1,2,2,3,3,3,4]
      r = Math.percentile(a,75)
      r.assert == 3.0
    end

    # Worked example of the NIST method:
    # https://en.wikipedia.org/wiki/Percentile#Worked_example_of_the_third_variant
    test "interpolates between ranks" do
      Math.percentile([15, 20, 35, 40, 50], 40).round(9).assert == 26.0
    end

    test "returns the value when the rank is whole" do
      Math.percentile([1, 2, 3], 50).assert == 2
    end

    test "high percentiles return the maximum (#289)" do
      Math.percentile([1, 2, 3], 90).assert == 3
      Math.percentile([1, 2, 3], 100).assert == 3
    end

    test "low percentiles return the minimum" do
      Math.percentile([1, 2, 3], 10).assert == 1
      Math.percentile([1, 2, 3], 0).assert == 1
    end

    test "is nil for an empty array" do
      Math.percentile([], 50).assert == nil
    end
  end

end
