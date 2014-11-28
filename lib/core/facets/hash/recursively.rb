require 'facets/functor'
require 'facets/enumerable/recursively'

class Hash

  # Apply a block to a hash, and recursively apply that block
  # to each sub-hash:
  #
  #     h = {:a=>1, :b=>{:x=>1, :y=>2}}
  #     h.recursively.map{ |k,v| [k.to_s, v] }
  #     #=> [["a", 1], ["b", [["y", 2], ["x", 1]]]]
  #
  # The recursive iteration can be treated separately from the non-recursive
  # iteration by passing a block to the #recursive method:
  #
  #     h = {:a=>1, :b=>{:x=>1, :y=>2}}
  #     h.recursively{ |k,v| [k.to_s, v] }.map{ |k,v| [k.to_s, v.to_s] }
  #     #=> [["a", "1"], ["b", [["y", "2"], ["x", "1"]]]]
  #
  def recursively(*types, &block)
    Recursor.new(self, *types, &block)
  end

  class Recursor < Enumerable::Recursor #:nodoc:
    def method_missing(op, &yld)
      yld = yld    || lambda{ |k,v| [k,v] }  # ? to_enum
      rec = @block || yld #lambda{ |k,v| [k,v] }
      @enum.__send__(op) do |k,v|
        case v
        when String # b/c of 1.8
          yld.call(k,v)
        when *@types
          res = v.recursively(*@types, &@block).__send__(op,&yld)
          rec.call(k, res)
        else
          yld.call(k,v)
        end
      end
    end
  end

## TODO: When no longer need 1.8.6 support.
=begin
  def recursively(*types, &block)
    types = types.empty? ? [self.class] : types
    Functor.new do |op, &yld|
      rec = block || yld
      __send__(op) do |k,v|
        case v
        when *types
          rec.call(k, v.recursively(*types, &block).__send__(op,&yld))
        else
          yld.call(k,v)
        end
      end
    end
  end
=end

end

