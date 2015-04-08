require 'facets/functor'
require 'facets/enumerable/recursively'

class Array

  # Apply a method to array, and recursively apply that method
  # to each sub-array or given +types+.
  #
  # By default the sub-types are passed through unaffected. Passing
  # a block to #recursively can be used to change this.
  #
  # types - List of class types to recurse. [Array<Class>]
  # block - Optional filter procedure to apply on each recursion.
  #
  # Examples
  #
  #   arr = ["a", ["b", "c"]]
  #   arr.recursively.map{ |v| v.to_sym }
  #   #=> [:a, [:b, :c]]
  #
  #   arr = ["a", ["b", "c"]]
  #   arr.recursively{ |a| a.reverse }.map{ |v| v.to_sym }
  #   #=> [:a, [:c, :b]]
  #
  # Returns [Recursor].

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
