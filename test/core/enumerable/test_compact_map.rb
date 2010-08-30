covers 'facets/enumerable/compact_map'

tests Enumerable do

  unit :compact_map do
    r = [1,2,nil,4].compact_map { |e| e }
    r.assert == [1,2,4]
  end

  unit :compact_collect do
    r = [1,2,nil,4].compact_collect { |e| e }
    r.assert == [1,2,4]
  end

=begin
  unit :map_send do
    r = [1,2,3].map_send(:+, 1)
    assert_equal(r, [2,3,4])
  end

  def test_map_send_with_block
    r = [1,2,3].map_send(:+,1){ |x| x + 1 }
    assert_equal(r, [3,4,5])
  end
=end

  #unit :filter_collect do
  #  e = [3,4]
  #  a = [1,2,3,4].filter_collect { |n|
  #    throw(:skip) if n < 3
  #    n
  #  }
  #  assert_equal( e, a )
  #end

end
