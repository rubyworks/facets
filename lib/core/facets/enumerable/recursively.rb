module Enumerable

  # Returns a recursive functor, that allows enumerable methods to iterate
  # through enumerable sub-elements. By default it only recurses over
  # elements of the same type.
  #
  def recursively(*types, &block)
    Recursor.new(self, *types, &block)
  end

  # Recursor is a specialized Functor for recurively iterating over Enumerables.
  #
  # TODO: Return Enumerator if no +yld+ block is given.
  #
  # TODO: Add limiting +depth+ option to Enumerable#recursively?
  #
  class Recursor
    instance_methods(true).each{ |m| private m unless /^(__|object_id$)/ =~ m.to_s }

    def initialize(enum, *types, &block)
      @enum   = enum
      @types  = types.empty? ? [@enum.class] : types
      @block  = block
    end

    def method_missing(op, &yld)
      rec = @block || lambda{ |v| v }
      yld = yld    || lambda{ |v| v }  # ? to_enum
      @enum.__send__(op) do |v|
        case v
        when String # b/c of 1.8
          yld.call(v)
        when *@types
          res = v.recursively(*@types, &@block).__send__(op,&yld)
          rec.call(res)
        else
          yld.call(v)
        end
      end
    end
  end

  ## TODO: When no longer needing to support 1.8.6 we could get rid of
  ## the Recursor class and use:
  ## #
  ## def recursively(*types, &block)
  ##   types = types.empty? ? [self.class] : types
  ##   Functor.new do |op, &yld|
  ##     rec = block || lambda{ |v| v }
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

