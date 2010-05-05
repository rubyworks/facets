Covers 'facets/symbol/generate'

Case Symbol do

  Unit :generate => "without key" do
    Symbol.generate.assert == :'-1'
    Symbol.generate.assert == :'-2'
  end

  Unit :generate => "with prefix key" do
    Symbol.generate('orange').assert == :'orange-1'
    Symbol.generate('orange').assert == :'orange-2'
  end

end

