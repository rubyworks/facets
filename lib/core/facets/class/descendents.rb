class Class

  # List all descedents of this class.
  #
  #   class X ; end
  #   class A < X; end
  #   class B < X; end
  #   X.descendents  #=> [A,B]
  #
  # NOTE: This is a intesive operation. Do not
  # expect it to be super fast.

  def descendents
    subclass = []
    ObjectSpace.each_object( Class ) do |c|
      if c.ancestors.include?( self ) and self != c
        subclass << c
      end
    end
    return subclass
  end

  unless defined?(::ActiveSupport)

    # Obvious alias for descendents.
    #
    # NOTE: ActiveSupport returns string names rather
    # then actual classes, so this is excluded
    # if ActiveSupport has already been loaded.
    #
    alias_method :subclasses, :descendents

  end

end

