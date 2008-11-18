#--
# SparseArray
#
# Copyright (c) 2004,2005 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.
#
# == AUTHOR(s)
#
# * Thamas Sawyer
#
# ==========================================================================
# Revision History ::
# --------------------------------------------------------------------------
#  04.09    Trans    * 99% Compatible with Array
# ==========================================================================
#++

#:title: SparseArray
#
# SparseArray is an implemenation of the Array class using only Hashes.
# Regular Arrays are never used except once to delegate the #pack method,
# and for *args parameters (since there is no way around those is some cases).
# SparseArray is for all practical purposes 100% compatible with Array.
#
# SparseArray is slower then the built in Array class, but not as slow
# as one might expect, since a Hash in general is faster than an Array.
# It might be interesting to see how this would perform if it were 
# written in c. Not all that useful, but an interesting example.
#
class SparseArray < Hash

  def self.[](*args)
    nha = new
    args.each { |a| nha.set(nha.length,a) }
    nha
  end

  def self.new_h(hsh)
    nha = new
    nha.replace(hsh)
    #nha.reindex!
  end

  def initialize(i=0,e=nil)
    if i > 0
      i.times { self.set(self.length,e) }
    end
  end

  def &(ha)
    nha = self.class.new
    (0..self.length-1).each do |i|
      if ha.has_value?(self.fetch(i)) and !nha.has_value?(self.fetch(i))
        nha.set(nha.length,self.fetch(i))
      end
    end
    nha
  end

  def *(j)
    if j.kind_of?(String)
      return self.join(j)
    else
      nha = self.class.new
      j.times { (0...self.length).each { |i| nha.set(nha.length,self.fetch(i)) } }
      return nha
    end
  end

  def +(ha)
    nha = self.dup
    (0..ha.length-1).each { |i| nha.set(nha.length,ha.fetch(i)) }
    nha
  end

  def -(ha)
    nha = self.class.new
    self.each { |v| nha << v if !ha.has_value?(v) }
    #ha.each { |v| nha << i if !self.include?(v) }
    nha
  end

  def <<(e)
    self.set(self.length,e)
    self
  end

  def <=>(ha)
    (0..self.length-1).each do |i|
      ieq = (self.fetch(i) <=> ha.fetch(i))
      return ieq if ieq != 0
    end
    self.length <=> ha.length
  end

  def ===(ha)
    self.==(ha)
  end

  alias_method :get, :[]
  private :get

  def [](i,l=nil)
    if l
      i = i...i+l
    elsif ! i.kind_of?(Range)
      return self.at(i)
    end
    nha = self.class.new
    i.each { |j| nha.set(nha.length,get(j)) if has_key?(j) }
    nha
  end

  alias set []=
  def []=(i,b,c=nil)
    if c
      rng = (Integer(i)..Integer(i+b))
      b = c
    elsif i.kind_of? Range
      rng = i
    else
      self.set(Integer(i),b)
      return b
    end
    if b == nil
      rng.each { |i| qdelete(i) }
      self.reindex!
    elsif b.kind_of?(Array) or b.kind_of?(self.class)
      j = 0
      rng.each { |i| self[i] = b[j]; j+=1 }
    else
      rng.each { |i| qdelete(i) }
      self[rng.fist] = b
      self.reindex!
    end
  end

  def |(ha)
    nha = self.dup
    ha.each { |v| nha << v if !nha.has_value?(v) }
    nha
  end

  def assoc(k)
    (0...self.length).each { |i| return self.fetch(i) if self.fetch(i)[0] == k }
    return nil
  end

  def at(i)
    i = self.length + i if i <= -1
    get(i)
    #return nil if i < 0 or i >= self.length
    #return self.fetch(i)
  end

  # clear okay

  def collect
    nha = self.class.new
    (0...self.length).each { |i| nha << yield(self.fetch(i)) }
    nha
  end

  def collect!
    nha = self.class.new
    (0...self.length).each { |i| nha << yield(self.fetch(i)) }
    self.replace(nha)
  end

  def compact
    nha, j = self.class.new, 0
    (0..self.length-1).each do |i|
      if self.fetch(i) != nil
        nha.set(j,self.fetch(i))
        j+=1
      end
    end
    nha
  end

  def compact!
    if self.has_value?(nil)
      nha, j = self.class.new, 0
      (0..self.length-1).each do |i|
        if self.fetch(i) != nil
          nha.set(j,self.fetch(i))
          j+=1
        end
      end
      return self.replace(nha)
    else
      return nil
    end
  end

  def concat(ha)
    (0...ha.length).each { |i| self.set(self.length,ha.fetch(i)) }
    self
  end

  def count(e=nil)
    if block_given?
      cnt = 0
      (0...self.length).each { |i| cnt += 1 if yield(self.fetch(i)) }
      return cnt
    else
      cnt = 0
      (0...self.length).each { |i| cnt += 1 if self.fetch(i) == e }
      return cnt
    end
  end

  alias qdelete delete
  private :qdelete

  def delete(e)
    if has_value?(e)
      qdelete_if { |i,v| v == e }
      reindex!
      return e
    else
      return yield if block_given?
      return nil
    end
  end

  def delete_at(i)
    if self.has_key?(i)
      e = self.fetch(i)
      qdelete(i)
      reindex!
      return e
    else
      return nil
    end
  end

  alias qdelete_if delete_if
  private :qdelete_if

  def delete_if
    qdelete_if { |i,v| yield(v) }
    reindex!
  end

  def each
    (0...self.length).each { |i| yield(self.fetch(i)) }
  end

  def each_index
    (0...self.length).each { |i| yield(i) }
  end

  # empty? okay as is

  def eql?(ha)
    return false if self.length != ha.length
    return true if (0...self.length).all? { |i| self.fetch(i).eql?(ha.fetch(i)) }
    return false
  end

  def fill(f,s=nil,l=nil)
    if s.kind_of?(Range)
      r = s
    else
      s = 0 if !s
      l = self.length - s if !l
      r = s...(s+l)
    end
    r.each{ |i| self.set(i,f) }
    self
  end

  def first
    return nil if self.empty?
    self.fetch(0)
  end

  def flatten
    nha = self.class.new
    (0...self.length).each do |i|
      sfi = self.fetch(i)
      if sfi.kind_of?(self.class) or sfi.kind_of?(Array)
        nha.concat(sfi.flatten)
      else
        nha.set(nha.length,sfi)
      end
    end
    nha
  end

  def flatten!
    return nil if !self.any? { |e| e.kind_of?(self.class) or e.kind_of?(Array) }
    self.replace(self.flatten)
  end

  def include?(v)
    self.has_value?(v)
  end

  # index okay

  def join(sep='')
    s = ''
    (0...self.length).each { |i| s << "#{self.fetch(i)}#{sep}" }
    return s.chomp(sep)
  end

  def last
    self[self.length-1]
  end

  # length okay

  alias map! collect!

  def nitems
    cnt = 0
    (0...self.length).each { |i| cnt += 1 if self.fetch(i) != nil }
    cnt
  end

  def pack(*args)
    self.to_a.pack(*args)
  end

  def pop
    self.delete_at(self.length-1)
  end

  def push(*e)
    self.concat(e)
  end

  def rassoc(k)
    (0...self.length).each { |i| return self.fetch(i) if self.fetch(i)[1] == k }
    return nil
  end

  def reindex
    nha, j, k, tl = self.class.new, 0, 0, self.length
    while k < tl
      if self.has_key?(j)
        nha.set(k,self.fetch(j))
        j+=1; k+=1
      else
        j+=1
      end
    end
    nha
  end

  def reindex!
    self.replace(self.reindex)
  end

  def reject!
    chg=nil
    qdelete_if { |i,v| r=yield(v); chg=true if r; r }
    return nil if !chg
    reindex!
  end

  #def replace(ha)
  #  if ha.length < self.length
  #    (ha.length..self.length-1).each { |i| self.delete(i) }
  #    (0..ha.length-1).each { |i| self.set(i,ha[i]) }
  #  end
  #end

  def reverse
    nha = self.class.new
    (0...self.length).each { |i| nha.set(self.length-1-i,self.fetch(i)) }
    nha
  end

  def reverse!
    (0...self.length/2).each do |i|
      ri = self.length-1-i
      tmp = self.fetch(ri)
      self.set(ri,self.fetch(i))
      self.set(i,tmp)
    end
    self
  end

  def reverse_each
    i = self.length - 1
    while i >= 0
      yield(self.fetch(i))
      i -= 1
    end
  end

  def rindex(e)
    i = self.length - 1
    while i >= 0
      return i if self.fetch(i) == e
      i -= 1
    end
    return nil
  end

  def shift
    e1 = self[0]
    tl = self.length - 1
    (1..tl).each { |i| self.set(i-1,self.fetch(i)) }
    self.delete_at(tl)
    e1
  end

  # size okay

  def slice(*args)
    self[*args]
  end

  def slice!(*args)
    result = self[*args]
    self[*args] = nil
    result
  end

  def sort
    raise "SparseArray does not currently support sorting with blocks" if block_given?
    nha = self.dup
    qsort(nha,0,nha.length-1)
  end

  def qsort(ha, l, r)
    l_hold = l
    r_hold = r
    pivot = ha[l]
    while l < r
      r -= 1 while (ha[r] <=> pivot) >= 0 and l < r
      if l != r
        ha[l] = ha[r]
        l += 1
      end
      l += 1 while (ha[l] <=> pivot) <= 0 and l < r
      if l != r
        ha[r] = ha[l]
        r -= 1
      end
    end
    ha[l] = pivot
    pivot = l
    l = l_hold
    r = r_hold
    qsort(ha,l,pivot-1) if l < pivot
    qsort(ha,pivot+1,r) if r > pivot
    ha
  end

  def sort!
    raise "SparseArray does not currently support sorting with blocks" if block_given?
    qsort(self,0,self.length-1)
  end

  def to_a
    a = []
    (0..self.length-1).each { |i| a << self.fetch(i) }
    a
  end

  def to_ary
    self
  end

  def to_h
   h = Hash.new
   self.each { |k,v| h[k] = v }
   h
  end

  def to_s
   self.join
  end

  def uniq
    nha = self.class.new
    (0..self.length-1).each do |i|
      nha[nha.length] = self[i] if !nha.has_value?(self[i])
    end
    nha
  end

  def uniq!
    j = 0
    (1..self.length-1).each do |i|
      if !self[0..j].has_value?(self[i])
        self[j+1] = self[i]
        j+=1
      end
    end
    (j+1..self.length-1).each { |i| qdelete(i) }
  end

  def unshift(e)
    i = self.length - 1
    while i >= 0
      self.set(i+1,self.fetch(i))
      return i if self.fetch(i) == e
      i -= 1
    end
    self.set(0,e)
    self
  end

  def values_at(*ix)
    nha = self.class.new
    ix.each {|i| nha[nha.length] = self.at(i)}
    nha
  end

end



=begin test

  # This is a mostly complete testcase for SparseArray.
  # SparseArray is tested by comparison to standard Array.

  require 'test/unit'

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

=end

