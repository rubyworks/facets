covers 'facets/kernel/presence'

tests Kernel do

  unit :presence do
    "a".presence.assert == "a"
    [1].presence.assert == [1]
    {:a=>1}.presence.assert == {:a=>1}
  end

  unit :presence do
    "".presence.assert == nil
    [].presence.assert == nil
    {}.presence.assert == nil
  end

  unit :present? do
    "a".assert.present?
    [1].assert.present?
    {:a=>1}.assert.present?
  end

  unit :present? do
    "".refute.present?
    [].refute.present?
    {}.refute.present?
  end

end
