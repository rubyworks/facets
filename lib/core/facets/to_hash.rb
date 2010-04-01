require 'facets/enumerator'
require 'facets/hash/dearray_values'

class Array

  # Converts an array into a hash. Converting an array
  # into a hash is not a one-to-one conversion, for this
  # reason #to_h examines at the array being converted
  # and then dispatches the conversion to the most sutiable
  # specialized function. There are three possiblities for this.
  #
  # If the array is a collection of perfect pairs, like that
  # which Hash#to_a generates, then conversion is handled by 
  # #to_h_flat.
  #
  #   a = [ [:a,1], [:b,2] ]
  #   a.to_h  #=> { :a=>1, :b=>2 }
  #
  # If the array contains only arrays, but are not perfect pairs,
  # then #to_h_multi is called.
  #
  #   a = [ [:a,1,2], [:b,2], [:c], [:d] ]
  #   a.to_h  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  #
  # If the array contians objects other then arrays then
  # the #to_h_splat method is called.
  #
  #   a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
  #   a.to_h  #=> { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
  #
  # Finally, a particular dispatch can be forced by 
  # specifying the +mode+ of conversion, eg. +:multi+,
  # +:splat+, +:flat+, +:assoc+, etc.
  #
  # Setting +mode+ to +true+ is the same as setting it +:multi+.
  # This has been left in for backward compatability.
  #
  # NOTE: The use of a +values+ parameter has been deprecated
  # because that functionality is as simple as:
  #
  #   array1.zip(array2).to_h
  #
  # CREDIT: Robert Klemme
  # CREDIT: Trans
  #
  #--
  # The +True+ option in the case statement provides some
  # backward compatability with the previous versions of this
  # method.
  #++

  def to_h(mode=nil)
    case mode
    when :splat
      return to_h_splat
    when :flat
      return to_h_flat
    when :multi, true
      return to_h_multi
    when :assoc
      return to_h_assoc
    else
      return to_h_auto
    end
  end

  # Converts an array into a hash. Converting an array
  # into a hash is not a one-to-one conversion, for this
  # reason #to_h examines at the array being converted
  # and then dispatches the conversion to the most sutiable
  # specialized function. There are three possiblities for this.
  #
  # If the array is a collection of perfect pairs, like that
  # which Hash#to_a generates, then conversion is handled by 
  # #to_h_flat.
  #
  #   a = [ [:a,1], [:b,2] ]
  #   a.to_h  #=> { :a=>1, :b=>2 }
  #
  # If the array contains only arrays, but are not perfect pairs,
  # then #to_h_multi is called.
  #
  #   a = [ [:a,1,2], [:b,2], [:c], [:d] ]
  #   a.to_h  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  #
  # If the array contians objects other then arrays then
  # the #to_h_splat method is called.
  #
  #   a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
  #   a.to_h  #=> { [:a,1,2]=>2, :b=>[:c,3], 9=>nil } 
  #
  def to_h_auto
    pairs = true
    mixed = false

    each do |e|
      case e
      when Array
        pairs = false if e.size > 2
      else
        mixed = true
      end
    end

    if mixed
      to_h_splat
    elsif pairs
      to_h_flat
    else
      to_h_multi
    end
  end

  # This is equivalent to Hash[*array], but it will pad
  # the array with a +nil+ object if there are not an even number
  # of elements.
  #
  #   a = [:a,1,:b,2,:c]
  #   a.to_h_splat  #=> { :a=>1, :b=>2, :c=>nil }
  #
  def to_h_splat
    a = dup
    a << nil if a.size % 2 == 1
    Hash[*a]
  end

  # This is equivalent to Hash[*array.flatten], but it will pad
  # the array with a +nil+ object if there are not an even number
  # of elements.
  #
  #   a = [:a,1,[:b,2,:c]]
  #   a.to_h_flat  #=> { :a=>1, :b=>2, :c=>nil }
  #
  def to_h_flat
    a = flatten
    a << nil if a.size % 2 == 1
    Hash[*a]
  end

  #def to_h_flat
  #  each_slice(2).inject({}) {|ha,(k,v)| ha[k]=v; ha}
  #end 

  # When a mixed or multi-element accociative array
  # is used, the result is as follows:
  #
  #   a = [ [:a,1,2], [:b,2], [:c], :d ]
  #   a.to_h  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  #
  # If the first entry of any subelements are the same, then
  # the value will be set to the last occuring value.
  #
  #   a = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ]
  #   a.to_h_assoc  #=> { :x=>4 }
  #
  def to_h_assoc
    h = {}
    each do |k,*v| 
      h[k] = v
    end
    h
  end

  # When a mixed or multi-element accociative array
  # is used, the result is as follows:
  #
  #   a = [ [:a,1,2], [:b,2], [:c], :d ]
  #   a.to_h  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  #
  # If the first entry of the subelements is the same, then
  # the values will be merged using #concat.
  #
  #   a = [ [:a,1,2], [:a,3], [:a,4], [:a], :a ]
  #   a.to_h_multi  #=> { :a=>[1,2,3,4] }
  #
  def to_h_multi
    h = {}
    each do |k,*v| 
      h[k] ||= []
      h[k].concat(v)
    end
    h
  end

  #def to_h_multi
  #  inject({}) {|h,a| h[a.first] = a[1..-1]; h}
  #end

  # Is this a good idea?
  #def to_hash
  #  h = {}
  #  each_with_index do |v, i|
  #    h[i] = v
  #  end
  #  h
  #end

end

class Hash

  # Return a rehashing of _self_.
  #
  #   {"a"=>1,"b"=>2}.to_h  #=> {"b"=>2,"a"=>1}
  #
  # CREDIT: Forian Gross

  def to_h; rehash; end

  # Returns _self_.
  #
  # CREDIT: Trans

  def to_hash; self; end

end

module Enumerable

  # Convert an Enumerable object into a hash by first
  # turning it into an array.
  #
  # CREDIT: Trans

  def to_h(mode=nil)
    to_a.to_h(mode)
  end

  def to_h_auto
    to_a.to_h_auto
  end

  def to_h_splat
    to_a.to_h_splat
  end

  def to_h_flat
    to_a.to_h_flat
  end

  def to_h_assoc
    to_a.to_h_assoc
  end

  def to_h_multi
    to_a.to_h_multi
  end

  #def to_hash
  #  to_a.to_hash
  #end

end

class NilClass

  # Allows <tt>nil</tt> to create an empty hash,
  # similar to #to_a and #to_s.
  #
  #   nil.to_h    #=> {}
  #
  # CREDIT: Trans

  def to_h; {}; end

end


class Enumerator

  # Convert an Enumerator object into a hash.
  # This is equivalent to Array#to_h.
  #
  #   e1 = [[1,:a],[2,:b],[3,:c]].to_enum
  #   e1.to_h #=> { 1=>:a, 2=>:b, 3=>:c }
  #
  #   e2 = [1,2,3,4,5].to_enum
  #   e2.to_h  #=> {5=>nil, 1=>2, 3=>4}
  #
  #   e3 = [1,2,1,3,1,5].to_enum
  #   e3.to_h #=> {1=>5}
  #
  # CREDIT: Sandor Szücs

  def to_h(mode=nil)
    to_a.to_h(mode)
  end

  # This is equivalent to Array#to_h_auto.
  #
  def to_h_auto
    to_a.to_h_auto
  end

  # This is equivalent to Array#to_h_splat.
  #
  def to_h_splat
    to_a.to_h_splat
  end

  # This is equivalent to Array#to_h_flat.
  #
  def to_h_flat
    to_a.to_h_flat
  end

  # This is equivalent to Array#to_h_assoc.
  #
  def to_h_assoc
    to_a.to_h_assoc
  end

  # This is equivalent to Array#to_h_multi.
  #
  def to_h_multi
    to_a.to_h_multi
  end

end

class Struct

  # Returns a hash containing the names and values
  # for all instance settings in the Struct.
  def to_h
    h = {}
    each_pair{ |k,v| h[k] = v }
    h
  end

end

