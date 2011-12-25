covers 'facets/hash/url_params'

testcase Hash do

  method :url_params do

    test 'simple hash' do
      hash1 = {:foo => "bar"}
      hash1.url_params.assert == "foo=bar"
    end

    test 'hash with array value' do
      hash2 = {"foo" => ["barf", "fab", 1]}
      hash2.url_params.assert == "foo=barf,fab,1"
    end

    test 'hash with multiple elements' do
      hash3 = {:foo => [:barf, :asdf,1], :fee => 1}
      hash3.url_params.assert == "foo=barf,asdf,1&fee=1"
    end

  end

end
