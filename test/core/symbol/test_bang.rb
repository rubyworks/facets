covers 'facets/symbol/bang'

testcase Symbol do

  unit :bang? do
    :a.refute.bang?
    :a?.refute.bang?
    :a!.assert.bang?
  end

end
