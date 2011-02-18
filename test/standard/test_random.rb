covers 'facets/random'

tests Random do

  metaunit :letter do
    100.times { |i| /[a-zA-z]/.assert =~ Random.letter }
  end

end

tests Range do

  # helper method
  def assert_at_rand_table(table)
    table.each do |x, y|
      20.times do
        x.at_rand.assert == y
      end
    end
  end

  # helper method
  def assert_random_range(range)
    20.times do 
      range.assert.include?( range.at_rand )
    end
  end

  unit :at_rand => "within range" do
    list = [ 1..4, 1...4, 1.5..2.5, 1.5...2.5, -4..-1, -4...-1,
             -2.5..-1.5, -2.5...-1.5, 'a'..'d', 'a'...'d' ]
    list.each{ |rng| assert_random_range(rng) }
  end

  unit :at_rand => "within range special cases" do
    assert_at_rand_table(
      (5..5)       => 5,
      (5...5)      => nil,
      (5..-1)      => nil,
      (5.0..5.0)   => 5.0,
      (5.0...5.0)  => nil,
      (5.0...-1.0) => nil
    )
  end

  unit :at_rand => "reverse ranges" do
    assert_at_rand_table(
      (4..1) => nil,
      (4...1) => nil,
      (-1..-4) => nil,
      (-1...-4) => nil
    )
    #assert((1..4).include?((4..1).at_rand))
    #assert((-4...-1).include?((-1...-4).at_rand))
    #assert((-4..-1).include?((-1..-4).at_rand))
  end

  # I'd rather it return the first sentinel than +nil+.
  # Really, ruby should be raising an error as an invalid range value.
  unit :at_rand => "exclusive range" do
    (5...5).at_rand.assert == nil
    #expect RangeError do
    #  (5...5).at_rand
    #end
  end

end

tests Array do

  unit :at_rand do
    a = [1,2,3,4,5]
    20.times{ a.assert.include?( a.at_rand ) }
  end

  unit :at_rand! do
    a = ['a','b','c']
    a.at_rand!.length.assert == 1
    a.length.assert == 2
  end

  unit :pick do
    a = ['a','b','c']
    a.pick(3).length.assert == 3
    a.length.assert == 3
    a = ['a','b','c']
    a.pick(4).length.assert == 3
    a.length.assert == 3
  end

  unit :pick! do
    a = ['a','b','c']
    a.pick!(3).length.assert == 3
    a.length.assert == 0
    a = ['a','b','c']
    a.pick!(4).length.assert == 3
    a.length.assert == 0
  end

  unit :rand_index do
    10.times {
      i = [1,2,3].rand_index
      (0..2).assert.include?(i)
    }
  end

  unit :rand_subset do
    10.times {
      a = [1,2,3,4].rand_subset
      a.size.assert <= 4
    }
  end

  unit :shuffle do
    a = [1,2,3,4,5]
    b = a.shuffle
    b.sort.assert == a
  end

  unit :shuffle! do
    a = [1,2,3,4,5]
    b = a.dup
    b.shuffle!
    b.sort.assert == a
  end

end

tests Hash do

  unit :rand_key do
    h = { :a=>1, :b=>2, :c=>3 }
    10.times { h.keys.assert.include?( h.rand_key ) }
  end

  unit :rand_pair do
    h = { :a=>1, :b=>2, :c=>3 }
    10.times { k,v = *h.rand_pair; h[k].assert == v }
  end

  unit :rand_value do
    h = { :a=>1, :b=>2, :c=>3 }
    10.times { h.values.assert.include?( h.rand_value ) }
  end

  unit :shuffle do
    h = {:a=>1, :b=>2, :c=>3 }
    h.shuffle
  end

  unit :shuffle! do
    h = {:a=>1, :b=>2, :c=>3 }
    h.shuffle!
  end

end

tests String do

  unit :at_rand do
    a = '12345'
    20.times{ a.assert.include?( a.at_rand ) }
  end

  unit :at_rand! do
    x = 'ab'
    r = x.at_rand!
    assert( r == 'a' || r == 'b' )
    assert( x == 'a' || x == 'b' )
  end

  unit :rand_index do
    10.times{ (0..2).assert.include?( 'abc'.rand_index ) }
  end

  unit :rand_byte do
    2.times do
      s = 'ab'
      r = s.rand_byte
      if RUBY_VERSION > '1.9'
        assert( r == 'a' || r == 'b' )
      else
        assert( r == 97 || r == 98 )
      end
    end
  end

  unit :shuffle do
    "abc 123".shuffle
    #"abc 123".shuffle!
  end

  unit :shuffle! do
    "abc 123".shuffle!
  end

end

