class Hash

  # Apply a block to hash, and recursively apply that block
  # to each subhash.
  #
  #   h = {:a=>1, :b=>{:b1=>1, :b2=>2}}
  #   h.recursively{|h| h.rekey(&:to_s) }
  #   => {"a"=>1, "b"=>{"b1"=>1, "b2"=>2}}
  #
  def recursive(opts={}, &block)
    if block
      h = inject({}) do |hash, (key, value)|
        if value.is_a?(Hash)
          hash[key] = value.recursively(&block)
        else
          hash[key] = value
        end
        hash
      end
      yield h
    else
      Recursor.new(self, opts)
    end
  end

  #

  def recursive!(&block)
    r = recursive(&block)
    raise TypeError unless Hash === r
    replace(r)
  end

  #
  class Recursor

    #
    def initialize(enum, opts)
      @enum = enum
      @opts = opts
    end

    # Returns a new hash created by traversing the hash and its subhashes,
    # executing the given block on the key and value. The block should
    # return a 2-element array of the form +[key, value]+.
    #
    #   h = { "A"=>"A", "B"=>"B", { "X"=>"X" } }
    #
    #   h.recursive_each{ |k,v| p [k.downcase, v] }
    #
    # produces
    #
    #   ["a", "A"]
    #   ["b", "B"]
    #   ["x", "X"]
    #
    # CREDIT: Trans

    def each(&block)
      @enum.each do |k,v|
        if Hash === v
          v = v.recursive.each(&block)
        elsif v.respond_to?(:to_hash)
          v = v.to_hash.recursive.each(&block)
        end
        block.call(k,v)
      end
      #@enum.each do |k,v|
      #  if Hash === v
      #    v.recursive.each(&block)
      #  else
      #    block.call(k,v)
      #  end
      #end
    end

    # Returns a new hash created by traversing the hash and its subhashes,
    # executing the given block on the key and value. The block should
    # return a 2-element array of the form +[key, value]+.
    #
    #   h = { "A"=>"A", "B"=>"B", { "X"=>"X" } }
    #
    #   g = h.recursive_map{ |k,v| [k.downcase, v] }
    #
    #   g  #=> [["a", "A"], ["b", "B"], [["x", "X"]]]
    #
    # CREDIT: Trans

    def map(&block)
      @enum.inject([]) do |a,(k,v)|
        if Hash === v
          v = v.recursive.map(&block)
        elsif v.respond_to?(:to_hash)
          v = v.to_hash.recursive.map(&block)
        end
        nk, nv = block.call(k,v)
        a << [nk, nv]
        a
      end
    end

    # In-place rendition of #recursive_map.

    def map!(&b)
      @enum.replace(map(&b))
    end

    # Returns a new hash created by traversing the hash and its subhashes,
    # executing the given block on the key and value. The block should
    # return a 2-element array of the form +[key, value]+.
    #
    #   h = {"A"=>"A", "B"=>"B", {"X"=>"X"}}
    #
    #   g = h.recursive_graph{ |k,v| [k.downcase, v] }
    #
    #   g  #=> {"a"=>"A", "b"=>"B", {"x"=>"X"}}
    #
    # CREDIT: Trans

    def graph(&block)
      @enum.inject({}) do |h,(k,v)|
        if Hash === v
          v = v.recursive.graph(&block)
        elsif v.respond_to?(:to_hash)
          v = v.to_hash.recursive.graph(&block)
        end
        nk, nv = block.call(k,v)
        h[nk] = nv
        h
      end
    end

    # In place version of traverse, which traverses the hash and its
    # subhashes, executing the given block on the key and value.
    #
    #   h = { "A"=>"A", "B"=>"B" }
    #
    #   h.traverse! { |k,v| [k.downcase, v] }
    #
    #   h  #=> { "a"=>"A", "b"=>"B" }
    #
    # CREDIT: Trans

    def graph!(&block)
      @enum.replace(graph(&block))
    end

    # Same as Hash#merge but recursively merges sub-hashes.

    def merge(other)
      hash = @enum.dup
      other.each do |key, value|
        myval = @enum[key]
        if value.is_a?(Hash) && myval.is_a?(Hash)
          hash[key] = myval.recursive.merge(value)
        else
          hash[key] = value
        end
      end
      hash
    end

    # Same as Hash#merge! but recursively merges sub-hashes.

    def merge!(other)
      other.each do |key, value|
        myval = @enum[key]
        if value.is_a?(Hash) && myval.is_a?(Hash)
          myval.recursive.merge!(value)
        else
          @enum[key] = value
        end
      end
      @enum
    end

  end

end

