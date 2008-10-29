# TODO:
#
#   - Remove require 'enumerator' for Ruby 1.9.
#   - Suggest Enumerator's #each_slice use block arity if no parameter is given.

require 'enumerator' # for each_slice

module Enumerable

  # Iterators over each element pairing.
  #
  #   [:a,:b,:c,:d].each_pair { |a,b|  puts "#{a} -> #{b}" }
  #
  # _produces_
  #
  #   a -> b
  #   c -> d
  #
  #  CREDIT: Martin DeMello

  def each_pair #:yield:
    e1 = nil
    each_with_index do |e,i|
      if i % 2 == 0
        e1 = e
        next
      else
        yield(e1,e)
      end
    end
  end

  # Iterate over each n items based on arity.
  #
  #   [1,2,3,4].eachn do |x, y|
  #     p [x,y]
  #   end
  #
  # _produces_
  #
  #   [1,2]
  #   [3,4]
  #
  #  CREDIT: Martin DeMello

  def eachn(&block)
    n = block.arity.abs
    each_slice(n) {|i| block.call(*i)}
  end


  # DEPRECATED
  #
  #   # Why the term counter? There may be a change in Ruby 2.0
  #   # to use this word instead of index. Index will
  #   # still be used for Array, since that is the proper meaning
  #   # in that context. In the mean time, aliases are provided.
  #
  #   # More appropriate naming since an enumerable is not
  #   # neccesarily "indexed", as is an Array or Hash.
  #   alias_method :each_with_counter, :each_with_index

end



=begin test

  def test_each_pair
    r = []
    a = [1,2,3,4]
    a.each_pair{ |a,b| r << [a,b] }
    assert_equal( [[1,2],[3,4]], r )
  end

  def test_eachn
    x = []
    [1,2,3,4].eachn{ |a,b| x << [a,b] }
    o = [[1,2],[3,4]]
    assert_equal( o, x )

    x = []
    [1,2,3,4,5].eachn{ |a,b,c| x << [a,b,c] }
    o = [[1,2,3],[4,5,nil]]
    assert_equal( o, x )
  end

=end

