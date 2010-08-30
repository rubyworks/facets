covers 'facets/symbol/generate'

testcase Symbol do

  metaunit :generate => "without key" do
    Symbol.generate.assert == :'-1'
    Symbol.generate.assert == :'-2'
  end

  metaunit :generate => "with prefix key" do
    Symbol.generate('orange').assert == :'orange-1'
    Symbol.generate('orange').assert == :'orange-2'
  end

end

