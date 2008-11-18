# This is a mostly complete testcase for SparseArray.
# SparseArray is tested by comparison to standard Array.

require 'test/unit'
require 'facets/sparse_array'

class TC_SparseArray < Test::Unit::TestCase

  def aha(a)
    return a, SparseArray[*a]
  end

  def test_conversions
    a, ha = aha [1,3,'a',8,nil,[1]]
    assert_equal(ha, ha.to_ary)  # these need to be opposite
    assert_equal(a, ha.to_a)     #
    assert_equal(a.to_s, ha.to_s)
  end

  def test_set_operations
    a, ha = aha [1,3,5,8,9]
    b, hb = aha [2,3,6,8,9]
    assert_equal(a | b, (ha | hb).to_a)
    assert_equal(a & b, (ha & hb).to_a)
    assert_equal(a + b, (ha + hb).to_a)
    assert_equal(a - b, (ha - hb).to_a)
  end

  def test_multiple
    a, ha = aha [1,3]
    assert_equal(a*3,(ha*3).to_a)
  end

  def test_assign
    a, ha = aha [1,2,3,4]
    a[1..2] = [8,9]
    ha[1..2] = [8,9]
    assert_equal(a, ha.to_a)
  end
  def test_assoc
    a, ha = aha [[1,2],[3,4],[3,6]]
    assert_equal(a.assoc(3), ha.assoc(3).to_a)
  end
  def test_at
    a, ha = aha [4,5,6,6]
    assert_equal(a.at(0), ha.at(0))
    assert_equal(a.at(2), ha.at(2))
    assert_equal(a.at(4), ha.at(4))
    assert_equal(a.at(9), ha.at(9))
    assert_equal(a.at(-1), ha.at(-1))
    assert_equal(a.at(-3), ha.at(-3))
    assert_equal(a.at(-4), ha.at(-4))
    assert_equal(a.at(-5), ha.at(-5))
  end
  def test_collect
    a, ha = aha [4,5,6,6]
    assert_equal(a.collect{|e|e}, ha.collect{|e|e}.to_a)
    assert_equal(a.collect!{|e|e}, ha.collect!{|e|e}.to_a)
    assert_equal(a,ha.to_a)
  end
  def test_compact
    a, ha = aha [4,nil,5,nil,6]
    assert_equal(a.compact, ha.compact.to_a)
  end
  def test_concat
    a, ha = aha [1,3,5,8,9]
    b, hb = aha [2,3,6,8,9]
    assert_equal(a.concat(b),ha.concat(hb).to_a)
  end
  def test_count
    ha = SparseArray[9,3,9,5,nil,nil,9,3]
    assert_equal(2,ha.count)
    assert_equal(2,ha.count(3))
    assert_equal(3,ha.count{|e|e==9})
  end
  def test_delete
    a, ha = aha [1,3,5,8,9,'a','b','c','c','d']
    # test delete
    assert_equal(a.delete(1),ha.delete(1))
    assert_equal(a,ha.to_a)
    assert_equal(a.delete('a'),ha.delete('a'))
    assert_equal(a,ha.to_a)
    # test delete_at
    assert_equal(a.delete_at(0),ha.delete_at(0))
    assert_equal(a,ha.to_a)
    # test delete_if
    assert_equal(a.delete_if{|v|v=='c'},ha.delete_if{|v|v=='c'}.to_a)
    assert_equal(a,ha.to_a)
  end
  def test_each
    a, ha = aha [4,'a',nil,'b']
    # test each
    ca, cha = '', ''
    a.each{|e| ca += e.to_s}
    ha.each{|e| cha += e.to_s}
    assert_equal(ca,cha)
    assert_equal(a,ha.to_a)
    # test each_index
    ca, cha = '', ''
    a.each_index{|i| ca += i.to_s}
    ha.each_index{|i| cha += i.to_s}
    assert_equal(ca,cha)
    assert_equal(a,ha.to_a)
  end
  def test_eql?
    a, ha = aha [4,'a',nil,'b']
    b, hb = aha [4,'a',nil,'b']
    assert_equal(a,b)
    assert_equal(ha,hb)
    assert_equal(a.eql?(b),ha.eql?(hb))
    assert_equal(b.eql?(a),hb.eql?(ha))
    assert(ha.eql?(hb))
    assert(hb.eql?(ha))
  end
  def test_empty?
    a, ha = aha []
    assert_equal(a.empty?,ha.empty?)
    a, ha = aha [1,2,3]
    assert_equal(a.empty?,ha.empty?)
  end
  def test_fill
    a, ha = aha ['a','b','c','d']
    assert_equal(a.fill('x'),ha.fill('x').to_a)
    assert_equal(a,ha.to_a)
    assert_equal(a.fill('y',2,2),ha.fill('y',2,2).to_a)
    assert_equal(a,ha.to_a)
    assert_equal(a.fill('z',0..1),ha.fill('z',0..1).to_a)
    assert_equal(a,ha.to_a)
  end
  def test_first
    a, ha = aha [2,3,4]
    assert_equal(a.first,ha.first)
  end
  def test_flatten
    a, ha = aha [2,[3],'a',[[1,2],4],nil,5]
    assert_equal(a.flatten,ha.flatten.to_a)
    a, ha = aha [2,[3],'a',[[1,2],4],nil,5]
    assert_equal(a.flatten!,ha.flatten!.to_a)
    assert_equal(a,ha.to_a)
    a, ha = aha [2,3,'a',nil,5]
    assert_equal(a.flatten!,ha.flatten!)
  end
  def test_include?
    a, ha = aha ['a','b','c','d']
    assert_equal(a.include?('b'),ha.include?('b'))
    assert_equal(a.include?('x'),ha.include?('x'))
  end
  def test_index
    a, ha = aha ['a','b','b','c','d']
    assert_equal(a.index('b'),ha.index('b'))
    assert_equal(a.index('x'),ha.index('x'))
  end
  def test_join
    a, ha = aha [2,3,4]
    assert_equal(a.join,ha.join)
    assert_equal(a.join(','),ha.join(','))
  end
  def test_last
    a, ha = aha [2,3,4]
    assert_equal(a.last,ha.last)
  end
  def test_length
    a, ha = aha [2,3,4]
    assert_equal(a.length,ha.length)
  end
  def test_map!
    a, ha = aha [4,5,6,6]
    assert_equal(a.map!{|e|e}, ha.map!{|e|e}.to_a)
    assert_equal(a,ha.to_a)
  end
  def test_nitems
    a, ha = aha [4,5,nil,6,nil]
    assert_equal(a.nitems, ha.nitems)
  end
  def test_pop
    a, ha = aha [4,5,nil,6,nil]
    assert_equal(a.pop, ha.pop)
    assert_equal(a, ha.to_a)
    assert_equal(a.pop, ha.pop)
    assert_equal(a, ha.to_a)
  end
  def test_push
    a, ha = aha [4,5,nil,6,nil]
    args = [1,2,3]
    assert_equal(a.push(*args), ha.push(*args).to_a)
    assert_equal(a, ha.to_a)
  end
  def test_rassoc
    a, ha = aha [[1,2],[1,3],[1,3]]
    assert_equal(a.rassoc(3), ha.rassoc(3).to_a)
  end
  def test_reject!
    a, ha = aha ['a','b','c','c','d']
    assert_equal(a.reject!{|v|v=='c'},ha.reject!{|v|v=='c'}.to_a)
    assert_equal(a,ha.to_a)
    assert_equal(a.reject!{|v|v=='x'},ha.reject!{|v|v=='x'})
    assert_equal(a,ha.to_a)
  end
  def test_reverse
    a, ha = aha ['a','b','c','c','d']
    assert_equal(a.reverse,ha.reverse.to_a)
    assert_equal(a.reverse!,ha.reverse!.to_a)
    assert_equal(a,ha.to_a)
    a, ha = aha [1,2,3,'a','b','c']
    assert_equal(a.reverse!,ha.reverse!.to_a)
    assert_equal(a,ha.to_a)
  end
  def test_reverse_each
    a, ha = aha [4,'a',nil,'b']
    # test each
    ca, cha = '', ''
    a.reverse_each{|e| ca += e.to_s}
    ha.reverse_each{|e| cha += e.to_s}
    assert_equal(ca,cha)
    assert_equal(a,ha.to_a)
  end
  def test_rindex
    a, ha = aha ['a','b','c','c','d']
    assert_equal(a.rindex('c'),ha.rindex('c'))
    assert_equal(a.rindex('x'),ha.rindex('x'))
  end
  def test_shift
    a, ha = aha ['a','b','c','c','d']
    assert_equal(a.shift,ha.shift)
    assert_equal(a,ha.to_a)
  end

  def test_slice
    a, ha = aha [1,2,3,4]
    # test []
    assert_equal(a[1], ha[1])
    assert_equal(a[1..2], ha[1..2].to_a)
    assert_equal(a[1...2], ha[1...2].to_a)
    assert_equal(a[1..7], ha[1..7].to_a)
    assert_equal(a[1,2], ha[1,2].to_a)
    # test slice
    assert_equal(a.slice(1), ha.slice(1))
    assert_equal(a.slice(1..2), ha.slice(1..2).to_a)
    assert_equal(a.slice(1...2), ha.slice(1...2).to_a)
    assert_equal(a.slice(1...2), ha.slice(1...2).to_a)
    assert_equal(a.slice(1,2), ha.slice(1,2).to_a)
    # test slice!
    assert_equal(a.slice!(1..2), ha.slice!(1..2).to_a)
    assert_equal(a, ha.to_a)
  end

  def test_sort
    a, ha = aha [1,2,3,4]
    # test sort
    assert_equal(a.sort, ha.sort.to_a)
    #assert_equal(a.sort{|x,y| y<=>x}, ha.sort{|x,y| y<=>x}.to_a)
    # test sort!
    assert_equal(a.sort!, ha.sort!.to_a)
    assert_equal(a, ha.to_a)
  end

  def test_uniq
    a, ha = aha [1,1,2,3,3,4,5,6,6]
    assert_equal(a.uniq, ha.uniq.to_a)
  end

  def test_uniq!
    a, ha = aha [1,1,2,3,3,4,5,6,6]
    a.uniq!; ha.uniq!
    assert_equal(a, ha.to_a)
  end

  def test_values_at
    a, ha = aha ['a','b','c','d']
    assert_equal(a.values_at(1,3),ha.values_at(1,3).to_a)
  end

  def test_unshift
    a, ha = aha ['a','b','c','c','d']
    assert_equal(a.unshift('x'),ha.unshift('x').to_a)
    assert_equal(a,ha.to_a)
  end
end

