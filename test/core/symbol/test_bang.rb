covers 'facets/symbol/bang'

test_case Symbol do

  method :bang? do

    test do
      :a.refute.bang?
      :a?.refute.bang?
      :a!.assert.bang?
    end

  end

end
