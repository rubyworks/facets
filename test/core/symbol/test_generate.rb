covers 'facets/symbol/generate'

test_case Symbol do

  class_method :generate do
    test "without key" do
      Symbol.generate.assert == :'-1'
      Symbol.generate.assert == :'-2'
    end
  end

  class_method :generate do
    test "with prefix key" do
      Symbol.generate('orange').assert == :'orange-1'
      Symbol.generate('orange').assert == :'orange-2'
    end
  end

end

