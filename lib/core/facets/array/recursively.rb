require 'facets/functor'
require 'facets/enumerable/recursively'

class Array

  # Apply a method to array, and recursively apply that method
  # to each sub-array or +types+.
  #
  #   arr = ["a", ["b", "c"]]
  #   arr.recursively.map{ |v| v.to_sym }
  #   #=> [:a, [:b, :c]]
  #
  # By default the sub-types are passed thru uneffected. Passing a block
  # to #recursively changes this.
  #
  #   arr = ["a", ["b", "c"]]
  #   arr.recursively{ |a| a.reverse }.map{ |v| v.to_sym }
  #   #=> [:a, [:c, :b]]
  #
  # TODO: Return Enumerator if no +yld+ block is given ?
  def recursively(*types, &block)
    Recursor.new(self, *types, &block)
  end

  ## TODO: When no longer needing to support 1.8.6 we could get rid of
  ## the Recursor class and use:
  ##
  ## def recursively(*types, &block)
  ##   types = types.empty? ? [self.class] : types
  ##   Functor.new do |op, &yld|
  ##     rec = block || lambda{ |a| a }
  ##     yld = yld   || lambda{ |v| v }  # ? to_enum
  ##     __send__(op) do |v|
  ##       case v
  ##       when String # b/c of 1.8
  ##         yld.call(v)
  ##       when *types
  ##         res = v.recursively(*types, &block).__send__(op,&yld)
  ##         rec.call(res)
  ##       else
  ##         yld.call(v)
  ##       end
  ##     end
  ##   end
  ## end

end
