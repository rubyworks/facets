covers 'facets/hash/to_params'

testcase Hash do
  unit :to_params do
    hash1 = {:foo => "bar"}
    hash2 = {"foo" => ["barf", "fab", 1]}
    hash3 = {:foo => [:barf, :asdf,1], :fee => 1}
    
    hash1.to_params.assert == "foo=bar"
    hash2.to_params.assert == "foo=barf,fab,1"
    hash3.to_params.assert == "foo=barf,asdf,1&fee=1"
  end
end