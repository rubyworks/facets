require 'facets/enumerable/recursive'

class Hash

  # Apply a block to hash, and recursively apply that block
  # to each subhash.
  #
  #   h = {:a=>1, :b=>{:b1=>1, :b2=>2}}
  #
  #   h.recursive{|h| h.inject({}){|h,(k,v)| h[k.to_s] = v; h} }
  #
  #   #=> {"a"=>1, "b"=>{"b1"=>1, "b2"=>2}}
  #
  def recursive(opts={}, &block)
    if block
      h = inject({}) do |hash, (key, value)|
        if value.is_a?(Hash)
          hash[key] = value.recursive(&block)
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
  class Recursor < Enumerable::Recursor

    #
    #def initialize(enum, opts)
    #  @enum = enum
    #  @opts = opts
    #end

    # Returns a new hash created by traversing the hash and its subhashes,
    # executing the given block on the key and value. The block should
    # return a 2-element array of the form +[key, value]+.
    #
    #   h = {"A"=>"A", "B"=>"B", "C"=>{"X"=>"X"}}
    #
    #   a = []
    #
    #   h.recursive.each{ |k,v| a << [k.downcase, v] }
    #
    #   a  #=> [["a", "A"],["b", "B"],["x", "X"],["c", {"X"=>"X"}]]
    #
    def each(&block)
      @enum.each do |k,v|
        if Hash === v
          v = v.recursive.each(&block)
        elsif v.respond_to?(:to_hash)
          v = v.to_hash.recursive.each(&block)
        end
        block.call(k,v)
      end
    end

    # Returns a new hash created by traversing the hash and its subhashes,
    # executing the given block on the key and value. The block should
    # return a 2-element array of the form +[key, value]+.
    #
    #   h = { "A"=>"A", "B"=>"B", "C"=>{ "X"=>"X" } }
    #
    #   g = h.recursive.map{ |k,v| [k.downcase, v] }
    #
    #   g  #=> [["a", "A"], ["b", "B"], ["c", [["x", "X"]]]]
    #
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

    # In-place rendition of #recursive.map.

    def map!(&b)
      @enum.replace(map(&b))
    end

    # Returns a new hash created by traversing the hash and its subhashes,
    # executing the given block on the key and value. The block should
    # return a 2-element array of the form +[key, value]+.
    #
    #   h = {"A"=>"A", "B"=>"B", "C"=>{"X"=>"X"}}
    #
    #   g = h.recursive.graph{ |k,v| [k.downcase, v] }
    #
    #   g  #=> {"a"=>"A", "b"=>"B", "c"=>{"x"=>"X"}}
    #
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
    #   h = { "A"=>"A", "B"=>"B", "C"=>{"X"=>"X"} }
    #
    #   h.recursive.graph! { |k,v| [k.downcase, v] }
    #
    #   h  #=> { "a"=>"A", "b"=>"B", "c"=>{"x"=>"X"} }
    #
    def graph!(&block)
      @enum.replace(graph(&block))
    end

    # Same as Hash#merge but recursively merges sub-hashes.
    #
    #   h1 = { :a=>1, :c=>{:x=>10} }
    #   h2 = { :b=>2, :c=>{:y=>11} }
    #
    #   h = h1.recursive.merge(h2)
    #
    #   h  #=> {:a=>1, :b=>2, :c=>{:x=>10, :y=>11} }
    #
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
    #
    #   h1 = { :a=>1, :c=>{:x=>10} }
    #   h2 = { :b=>2, :c=>{:y=>11} }
    #
    #   h1.recursive.merge!(h2)
    #
    #   h1  #=> {:a=>1, :b=>2, :c=>{:x=>10, :y=>11} }
    #
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

    private

    #
    def process(op, k, v, &b)
      case v
      when String # b/c of 1.8
        b.call(k, v)
      when *@types
        v.recursive(*@types).__send__(op,&b)
      else
        b.call(k, v)
      end
    end

  end

end

