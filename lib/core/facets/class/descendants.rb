require 'facets/class/subclasses'

class Class

  # List all descedents of this class.
  #
  #   class A ; end
  #   class B < A; end
  #   class C < A; end
  #   A.descendants  #=> [B,C]
  #
  # You may also limit the generational distance the subclass may be from
  # the parent class.
  #
  #   class X ; end
  #   class Y < X; end
  #   class Z < Y; end
  #   X.descendants    #=> [Y,Z]
  #   X.descendants(1) #=> [Y]
  #
  # NOTE: This is a intensive operation. Do not expect it to be very fast.

  def descendants(generations=-1)
    descendants = []
    subclasses.each do |k|
      descendants << k
      if generations != 1
        descendants.concat(k.descendants(generations - 1))
      end
    end
    descendants
  end

end

