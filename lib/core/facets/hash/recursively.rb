require 'facets/functor'

class Hash

  # Apply a block to a hash, and recursively apply that block
  # to each sub-hash.
  #
  #   h = {:a=>1, :b=>{:x=>1, :y=>2}}
  #   h.recursive.map{ |k,v| [k.to_s,v] }
  #   #=> {"a"=>1, "b"=>{"x"=>1, "y"=>2}}
  #
  # The recursive iteration can be treated separately from the non-recursive
  # iteration by passing a block to the #recursive method.
  #
  #   h = {:a=>1, :b=>{:x=>1, :y=>2}}
  #   h.recursive{ |k,v| [k.to_s, v.to_s] }.map{ |k,v| [k.to_s,v] }
  #   #=> {"a"=>"1", "b"=>{"x"=>"1", "y"=>"2"}}
  #
  def recursively(*types, &block)
    types = types.empty? ? [self.class] : types
    Functor.new do |op, &yld|
      rec = block || yld
      rec.call __send__(op) do |k,v|
        case v
        when *types
          rec.call(k, v.recursively(*types, &block).__send__(op,&yld))
        else
          yld.call(k,v)
        end
      end
    end
  end

end



=begin
  #
  class Recursor

    def initialize(enum, types, &block)
      @enum  = enum
      @types = types.empty? ? [enum.class] : types
      @rec   = block
    end

    #
    def map(&block)
      @enum.map do |k,v|
        case v
        when *types
          @rec.call(k, v.recursive.map(&block))
        else
          block.call(k,v)
        end
      end
    end

    #
    def graph(&block)
      @enum.graph do |k,v|
        if Hash===v
          @rec.call(k, v.recursive.graph(&block))
        else
          block.call(k,v)
        end
      end
    end

    def method_missing(op, &block)
      rec_block = @rec || block
      @enum.__send__(op) do |k,v|
        case v
        when *@types
          rec_block.call(k, v.recursive.__send__(op,&block))
        else
          block.call(k,v)
        end
      end
    end

  end
=end

