covers 'facets/hash/to_struct'

test_case Hash do

  method :to_struct do

    test do
      h = {:name=>"Dan","age"=>33,"rank"=>"SrA","grade"=>"E4"}
      s = h.to_struct("Foo")

      s.name.assert  = "Dan"
      s.age.assert   = 33
      s.rank.assert  = "SrA"
      s.grade.assert = "E4"

      #Foo.assert.is_a?(Struct) ?
    end

  end
  
end

