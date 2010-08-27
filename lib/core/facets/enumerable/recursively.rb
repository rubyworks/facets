module Enumerable

  # Returns a recursive functor, that allows enumerable methods to iterate
  # through enumerable sub-elements. By default it only recurses over
  # elements of the same type.
  #
  #--
  # TODO: Return Enumerator if no +yld+ block is given.
  #
  # TODO: Add limiting +depth+ option to Enumerable#recursively ?
  #++
  def recursively(*types, &block)
    types = types.empty? ? [self.class] : types
    Functor.new do |op, &yld|
      rec = block || lambda{ |v| v }
      yld = yld   || lambda{ |v| v }  # ? to_enum
      __send__(op) do |v|
        case v
        when String # b/c of 1.8
          yld.call(v)
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

