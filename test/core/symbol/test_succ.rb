covers 'facets/symbol/succ'

test_case Symbol do

  method :succ do

    test do
      :a.succ.assert == :b
      :aaa.succ.assert == :aab
      :"1".succ.assert == :"2"
    end

  end

end

