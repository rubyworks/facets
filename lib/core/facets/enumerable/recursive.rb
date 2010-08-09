module Enumerable

  # Returns a Recursor, a recrusive functor, that allows enumerable methods
  # to iterate through enumerable sub-elements. By default it only recurses
  # over only elements of thes same type.
  #--
  # TODO: Add limiting +depth+ option to Enumerable#recursive
  #++
  def recursive(*types)
    Recursor.new(self, *types)
  end

  # Recursor "functor".
  #
  # NOTE: THIS IS A WORK IN PROGRESS!
  class Recursor

    def initialize(enum, *types)
      @enum  = enum
      @types = types.empty? ? [enum.class] : types
    end

    # Recursive iteration over enumerables.
    #
    #   a = []
    #
    #   [1, 2, [3, 4]].recursive.each{ |e| a << e }
    #
    #   a  #=> [1,2,3,4]
    #
    def each(&b)
      @enum.each{ |*v| process(:each, *v, &b) }
    end

    # Recursive map.
    #
    #   [1, 2, ['a', 'b']].recursive.map{ |e| e.succ }
    #   #=> [2, 3, ['b', 'c']]
    #
    def map(&b)
      @enum.map{ |*v| process(:map, *v, &b) }
    end

    #--
    # I don't think this can work ...
    #
    #   def graph(&b)
    #     @enum.graph{ |*v| process(:graph, *v, &b) }
    #   end
    #++

    # In place #map. This will raise an error if the enumerator
    # does not respond to #replace.
    def map!(&b)
      @enum.replace(map(&b))
    end

    private

    # NOTE: Technically this should check for the proper conversion
    # method if applicable, eg. #to_ary for Array, rather than
    # just checking the class type. In the future this may be 
    # generally supported if Facets ever adds a "class know-thy-self"
    # library. In the meantime override in classes are required to
    # incorporate this.

    def process(op, v, &b)
      case v
      when String # b/c of 1.8
        b.call(v)
      #when @enum.class
      #  v.recursive(*@types).__send__(op,&b)
      when *@types
        v.recursive(*@types).__send__(op,&b)
      else
        b.call(v)
        #--
        # What about ... 
        #
        #  if @opts[:skip] && Enumerable === v
        #    v
        #  else
        #    b.call(v)
        #  end
        #++
      end
    end

  end

end

