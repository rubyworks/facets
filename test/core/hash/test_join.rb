covers 'facets/hash/join'

tests Hash do

  setup do
    {:a=>1, :b=>2}
  end

  unit :join do |h|
    s = h.join
    s.assert.include?('b2')
    s.assert.include?('a1')
  end

  unit :join do |h|
    s = h.join(',')
    s.assert.include?('a,1')
    s.assert.include?('b,2')
  end

  unit :join do |h|
    s = h.join(',', ':')
    s.assert.include?('a,1')
    s.assert.include?('b,2')
    s.assert.include?(':')
  end

end
