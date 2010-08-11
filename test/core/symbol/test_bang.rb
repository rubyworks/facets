Covers 'facets/symbol/bang'

TestCase Symbol do

  unit :bang? do
    :a.refute.bang?
    :a?.refute.bang?
    :a!.assert.bang?
  end

end
