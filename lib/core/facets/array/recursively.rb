require 'facets/functor'

class Array

  # Apply a method to array, and recursively apply that method
  # to each sub-array or +types+.
  #
  #   arr = ["a", ["b", "c", nil], nil]
  #   arr.recursively{ |v| v.compact! }.map{ |v| v }
  #   #=> ["a", ["b", "c"]]
  #
  def recursively(*types, &block)
    types = types.empty? ? [self.class] : types
    Functor.new do |op, &yld|
      rec = block || yld
      yld = yld   || lambda{ |v| v }  # ?
      rec.call __send__(op) do |v|
        case v
        when *types
          res = v.recursively(*types, &block).__send__(op,&yld)
          rec.call(res)
        else
          yld.call(v)
        end
      end
    end
  end

end
