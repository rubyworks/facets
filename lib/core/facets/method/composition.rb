class Method

  # Method Composition class.
  #
  # CREDIT: Mike Burns
  class Composition

    #
    def initialize(f,g)
      @f = f
      @g = g
    end

    #
    def *(h)
      Composition.new(self, h)
    end

    #
    def ^(n)
      return self if n < 2
      Composition.new(self, self ^ (n-1))
    end

    #
    def owner
      @g.owner
    end

    #
    def receiver
      @g.receiver
    end

    #
    def inspect
      "#<Method::Composition: #{@f.inspect} * #{@g.inspect}>"
    end

    #
    def arity
      @g.arity
    end

    #
    def to_proc
      Proc.new {|x| @f.call(*@g.call(*x)) }
    end

    #
    def call(x)
      @f.call(*@g.call(*x))
    end

    #
    def [](*x)
      call(*x)
    end

  end

  # Method composition.
  #
  # CREDIT: Mike Burns
  def *(g)
    Composition.new(self,g)
  end

  # Method repition.
  #
  # CREDIT: Mike Burns
  def ^(n)
    if n < 2
      self
    else
      Composistion.new(self, self ^ (n-1))
    end
  end

end
