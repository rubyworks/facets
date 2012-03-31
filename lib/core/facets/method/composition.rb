class Method

  # TODO: Is it really necessary to have method composition?
  # Could we not just convert to Proc and have Proc omposition,
  # which doesn't require a special class (albeit #owner and #arity
  # and such are not as well supported).

  # Method Composition class acts a proxy for composed methods.
  #
  # @author Mike Burns
  class Composition

    #
    def initialize(*f)
      @f = f
    end

    #
    def inspect
      x = @f.map{ |f| f.inspect }.join(' * ')
      "#<Method::Composition: #{x}>"
    end

    #
    def *(h)
      #Composition.new(self, h)
      @f << h
    end

    #
    def ^(n)
      raise ArgumentError if n < 0

      return self if n < 2

      #Composition.new(self, self ^ (n-1))
      (n - 1).times{ @f = @f.concat(@f) }
    end

    #
    def owner
      @f.last.owner
    end

    #
    def receiver
      @f.first.receiver
    end

    #
    def arity
      @f.last.arity
    end

    #
    def to_proc
      #Proc.new {|x| @f.call(*@g.call(*x)) }
      Proc.new { |*x| call(*x) }
    end

    #
    def call(*x)
      r = x
      @f.reverse_each do |f|
        r = f.call(*r)
      end
      r
    end

    #
    def [](*x)
      call(*x)
    end

  end

  # Method composition.
  #
  # @author Mike Burns
  def *(g)
    Composition.new(self, g)
  end

  # Method repetition.
  #
  # @author Mike Burns
  def ^(n)
    if n < 2
      self
    else
      #Composition.new(self, self ^ (n-1))
      Composition.new( *([self] * n) )
    end
  end

end
