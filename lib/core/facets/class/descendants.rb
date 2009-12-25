class Class

  # List all descedents of this class.
  #
  #   class X ; end
  #   class A < X; end
  #   class B < X; end
  #   X.descendents  #=> [A,B]
  #
  # You may also limit the generational distance
  # the subclass may be from the parent class.
  #
  #   class X ; end
  #   class A < X; end
  #   class B < A; end
  #   X.descendents    #=> [A, B]
  #   X.descendents(1) #=> [A]
  #
  # NOTE: This is a intensive operation. Do not
  # expect it to be super fast.

  def descendants(generations=nil)
    subclass = []
    ObjectSpace.each_object(Class) do |c|
      ancestors = c.ancestors[0..(generations || -1)]
      if ancestors.include?(self) and self != c
        subclass << c
      end
    end
    return subclass
  end

  #
  alias_method :descendents, :descendants

  unless defined?(::ActiveSupport)

    # Obvious alias for descendants.
    #
    # NOTE: ActiveSupport returns string names rather
    # then actual classes, so this is excluded
    # if ActiveSupport has already been loaded.
    alias_method :subclasses, :descendants

  end

end

