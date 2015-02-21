#require 'facets/enumerator'
require 'facets/hash/dearray_values'
require 'facets/enumerable/value_by'

module Enumerable

  # The hashify methods is a higher-order message used to
  # convert an enumerable object into a hash. Converting an
  # enumerable object into a hash is not a one-to-one conversion,
  # for this reason #hashify is used to provide variant approches
  # for the conversion most suited to the use case at hand.
  # Here are some (but not a complete set of) examples.
  #
  # If the enumerable is a collection of perfect pairs, like that
  # which Hash#to_a generates, then #assoc can be used.
  #
  #   a = [ [:a,1], [:b,2] ]
  #   a.hashify.assoc  #=> { :a=>1, :b=>2 }
  #
  # If it it contains only arrays, but are not perfect pairs,
  # then #concat can be used.
  #
  #   a = [ [:a,1,2], [:b,2], [:c], [:d] ]
  #   a.hashify.concat  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
  #
  # If the array contains objects other then arrays then
  # the #splat method might do the trick.
  #
  #   a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
  #   a.hashify.splat  #=> { [:a,1,2]=>2, :b=>[:c,3], 9=>nil }
  #
  # Also, the particular dispatch can be left up the Hashify
  # using the #auto method. See Hashify#auto for details on this.
  #
  # TODO: This method takes arguments only for the sake of the old
  # method which has been deprecated. These will be removed eventually.
  #
  # CREDIT: Robert Klemme, Sandor Szücs, Trans

  def hashify(val=nil, &block)
    if val
      warn "The old Enumerable#hashify method has been be deprecated. Use #value_by instead."
      value_by{ val }
    end

    if block
      warn "The old Enumerable#hashify method has been be deprecated. Use #value_by instead."
      value_by(&block)
    end

    Hashifier.new(self)
  end

  #
  class Hashifier

    def initialize(enum)
      @enum = enum
    end

    # This is equivalent to Hash[*array], but it will pad
    # the array with a +nil+ object if there are not an even number
    # of elements.
    #
    #   a = [:a,1,:b,2,:c]
    #   a.to_h_splat  #=> { :a=>1, :b=>2, :c=>nil }
    def splat
      a = @enum.to_a
      a << nil if a.size.odd?
      Hash[*a]
    end

    # This is equivalent to Hash[*array.flatten], but it will pad
    # the array with a +nil+ object if there are not an even number
    # of elements.
    #
    #   a = [:a,1,[:b,2,:c]]
    #   a.to_h_flat  #=> { :a=>1, :b=>2, :c=>nil }
    def flat
      a = @enum.to_a.flatten
      a << nil if a.size.odd?
      Hash[*a]
    end

    # When a mixed or multi-element associative array
    # is used, the result is as follows:
    #
    #   a = [ [:a,1,2], [:b,2], [:c], :d ]
    #   a.hashify.assoc  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    #
    # If the first entry of any subelements are the same, then
    # the value will be set to the last occurring value.
    #
    #   a = [ :x, [:x], [:x,1,2], [:x,3], [:x,4] ]
    #   a.hashify.assoc  #=> { :x=>[4] }
    #
    def associate
      h = {}
      each do |k,*v|
        h[k] = v
      end
      h
    end

    # Alias for #associate.
    alias :assoc :associate

    # Like associate but does force values into an array.
    #
    def merge
      h = {}
      each do |k,v|
        h[k] = v
      end
      h
    end

    # When a mixed or multi-element associative array
    # is used, the result is as follows:
    #
    #   a = [ [:a,1,2], [:b,2], [:c], :d ]
    #   a.hashify.concat  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    #
    # If the first entry of the subelements is the same, then
    # the values will be merged using #concat.
    #
    #   a = [ [:a,1,2], [:a,3], [:a,4], [:a], :a ]
    #   a.hashify.concat  #=> { :a=>[1,2,3,4] }
    #
    def concat
      h = {}
      each do |k,*v|
        h[k] ||= []
        h[k].concat(v)
      end
      h
    end

    # Older name for #concat.
    alias :multi :concat

    # Convert enumerable object to Hash using index as keys.
    #
    #   [:a, :b, :c].hashify.by_index  #=> {1=>:a, 2=>:b, 3=>:c}
    #
    def by_index
      h = {}
      each_with_index do |v, i|
        h[i] = v
      end
      h
    end

    # Converts enumerable object into a hash. Converting an array
    # into a hash is not a one-to-one conversion, for this
    # reason #auto examines the enumerable being converted
    # and then dispatches the conversion to the most suitable
    # specialized function. There are three possibilities for this.
    #
    # If the enumerable is a collection of perfect pairs, like that
    # which Hash#to_a generates, then conversion is handled by
    # #flat.
    #
    #   a = [ [:a,1], [:b,2] ]
    #   a.hashify.auto  #=> { :a=>1, :b=>2 }
    #
    # If it contains only arrays, but are not perfect pairs,
    # then #multi is called.
    #
    #   a = [ [:a,1,2], [:b,2], [:c], [:d] ]
    #   a.hashify.auto  #=> { :a=>[1,2], :b=>[2], :c=>[], :d=>[] }
    #
    # If it contains objects other then arrays then the #splat method
    # is called.
    #
    #   a = [ [:a,1,2], 2, :b, [:c,3], 9 ]
    #   a.hashify.auto  #=> { [:a,1,2]=>2, :b=>[:c,3], 9=>nil }
    #
    # Be aware this is not as efficient as using the underlying methods
    # directly because it must perform an initial iteration over the
    # enumerable to determine its contents.

    def auto(&block)
      pairs, mixed = true, false

      each do |e|
        case e
        when Array
          pairs = false if e.size > 2
        else
          mixed = true
        end
      end

      if mixed
        splat(&block)
      elsif pairs
        flat(&block)
      else
        multi(&block)
      end
    end

    # Alias for `#auto`.
    alias :automatic :auto

  private

    #
    def each(&b)
      @enum.each(&b)
    end

    #
    def each_with_index(&b)
      @enum.each_with_index(&b)
    end

  end

end


#class Enumerator
#  # See `Enumerable#hashify`.
#  def hashify
#    Hashifier.new(self)
#  end
#end

