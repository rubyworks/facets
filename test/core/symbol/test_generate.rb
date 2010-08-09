Covers 'facets/symbol/generate'

Case Symbol do

  MetaUnit :generate => "without key" do
    Symbol.generate.assert == :'-1'
    Symbol.generate.assert == :'-2'
  end

  MetaUnit :generate => "with prefix key" do
    Symbol.generate('orange').assert == :'orange-1'
    Symbol.generate('orange').assert == :'orange-2'
  end

end

