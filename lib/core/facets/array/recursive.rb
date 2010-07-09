require 'facets/enumerable/recursive'

class Array

  # Apply a block to array, and recursively apply that block
  # to each subarray.
  #
  #   arr = ["a", ["b", "c", nil], nil]
  #   arr.recursive{ |a| a.compact! }
  #   #=> ["a", ["b", "c"]]
  #
  def recursive(opts={}, &block)
    if block
      a = inject([]) do |array, value|
        if value.is_a?(Array)
          array << value.recursive(&block)
        else
          array << value
        end
        array
      end
      yield a
    else
      Recursor.new(self, opts)
    end
  end

  # In place form of #recursive.

  def recursive!(&block)
    r = recursive(&block)
    raise TypeError unless Array === r
    replace(r)
  end

 
  #
  class Recursor < ::Enumerable::Recursor

    # Recursively iterate over the Array's elements.
    # If an element is an Array or responds to #to_ary
    # then it will be itereated over as well.
    #
    def each(&block)
      if block_given?
        @enum.each do |e|
          if Array === e || e.respond_to?(:to_ary)
            e.to_ary.recursive.each(&block)
          else
            block.call(e)
          end
        end
      else
        to_enum(:each)
      end
    end

    # Returns a new array created by traversing the array and its
    # sub-arrays, executing the given block on the elements.
    #
    #   h = ["A", "B", ["X", "Y"]]
    #
    #   g = h.recursive.map{ |e| e.downcase }
    #
    #   g = ["a", "b", ["x", "y"]]
    #
    # CREDIT: Trans

    def map(&block)
      if block_given?
        @enum.map do |e|
          if Array === e || e.respond_to?(:to_ary)
            e.to_ary.recursive.map(&block)
          else
            block.call(e)
          end
        end
      else
        to_enum(:map)
      end
    end

    # Like #map, but will change the array in place.

    def map!(&block)
      replace(map(&block))
    end

  end

end

