module Enumerable

  def recursive(opts={})
    Recursor.new(self, opts)
  end

  # Recursor "functor".
  #
  # NOTE: THIS IS A WORK IN PROGRESS!
  #
  class Recursor

    def initialize(enum, opts)
      @enum = enum
      @opts = opts
    end

    # Recursive iteration over enumerables.
    #
    #   [1, 2, [3, 4]].recursive.each{ |e| p e }
    #
    # produces
    #
    #   1
    #   2
    #   3
    #   4
    #
    # NOTE: Technically this should check for the proper conversion
    # method if applicable, eg. #to_ary for Array, rather than
    # just checking the class type. In the future this may be 
    # generally supported if Facets ever adds a "class know-thy-self"
    # library. In the meantime override in classes are required to
    # incorporate this.

    def each(&b)
      @enum.each{ |*v| process(:each, *v, &b) }
    end

    # Recursive map.
    #
    #   [1, 2, ['a', 'b']].recursive.map{ |e| e.succ }
    #   #=> [1, 2, ['b', 'c']]
    #
    def map(&b)
      @enum.map{ |*v| process(:map, *v, &b) }
    end

    #
    #def graph(&b)
    #  @enum.graph{ |*v| process(:graph, *v, &b) }
    #end

    private

    #
    def process(op, v, &b)
      case v
      when String # b/c of 1.8
        b.call(v)
      when @enum.class
        v.recursive(@opts).send(op,&b)
      else
        #if @opts[:skip] && Enumerable === v
        #  v
        #else
          b.call(v)
        #end
      end
    end

  end

end

