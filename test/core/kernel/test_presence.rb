covers 'facets/kernel/presence'

test_case Kernel do

  method :presence do

    test do
      "a".presence.assert == "a"
      [1].presence.assert == [1]
      {:a=>1}.presence.assert == {:a=>1}
    end

    test do
      "".presence.assert == nil
      [].presence.assert == nil
      {}.presence.assert == nil
    end

  end

  method :present? do

    test "non-empty objects are present" do
      "a".assert.present?
      [1].assert.present?
      {:a=>1}.assert.present?
    end

    test "empty object are not present" do
      "".refute.present?
      [].refute.present?
      {}.refute.present?
    end

  end

end
