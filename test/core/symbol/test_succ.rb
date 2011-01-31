covers 'facets/symbol/succ'

testcase Symbol do

  unit :succ do
    :a.succ.assert == :b
    :aaa.succ.assert == :aab
    :"1".succ.assert == :"2"
  end

end

