require 'facets/class/subclasses'

class Class

  # List all descedents of this class.
  #
  #   class X ; end
  #   class A < X; end
  #   class B < X; end
  #   X.descendents  #=> [A,B]
  #
  # You may also limit the generational distance the subclass may be from
  # the parent class.
  #
  #   class X ; end
  #   class A < X; end
  #   class B < A; end
  #   X.descendents    #=> [A, B]
  #   X.descendents(1) #=> [A]
  #
  # NOTE: This is a intensive operation. Do not expect it to be very fast.

  def descendants(generations=-1)
    descendants = []
    subclasses.each do |k|
      descendants << k
      if generations != 0
        descendants.concat(k.descendants(generations - 1))
      end
    end
    descendants
  end

end

