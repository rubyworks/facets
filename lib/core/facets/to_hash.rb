class Array

  # Converts a two-element associative array into a hash.
  #
  #   a = [ [:a,1], [:b,2] ]
  #   a.to_h  #=> { :a=>1, :b=>2 }
  #
  # If +arrayed+ is set it will maintain trailing arrays.
  #
  #   a = [ [:a,1,2], [:b,3] ]
  #   a.to_h(true)  #=> { :a=>[1,2], :b=>[3] }
  #
  # Note that the use of a values parameter has been deprecated
  # because that functionality is as simple as:
  #
  #   array1.zip(array2).to_h
  #
  #  CREDIT: Trans

  def to_h(arrayed=nil)
    h = {}
    if arrayed #or (flatten.size % 2 == 1)
      #each{ |e| h[e.first] = e.slice(1..-1) }
      each{ |k,*v| h[k] = v }
    else
      #h = Hash[*flatten(1)] # TODO Use in 1.9 instead.
      ary = []
      each do |a|
        Array===a ? ary.concat(a) : ary << a
      end
      h = Hash[*ary]
    end
    h
  end

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

end

module Enumerable

  # Convert an Enumerable object into a hash by first
  # turning it into an array.
  #
  # CREDIT: Trans

  def to_h(arrayed=nil)
    to_a.to_h(arrayed)
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

