covers 'facets/hash/join'

test_case Hash do

  method :join do

    setup do
      @h = {:a=>1, :b=>2}
    end

    test do
      s = @h.join
      s.assert.include?('b2')
      s.assert.include?('a1')
    end

    test do
      s = @h.join(',')
      s.assert.include?('a,1')
      s.assert.include?('b,2')
    end

    test do
      s = @h.join(',', ':')
      s.assert.include?('a,1')
      s.assert.include?('b,2')
      s.assert.include?(':')
    end

  end

end
