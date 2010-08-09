Covers 'facets/symbol/succ'

Case Symbol do

  Unit :succ do
    :a.succ.assert == :b
    :aaa.succ.assert == :aab
    :"1".succ.assert == :"2"
  end

end

