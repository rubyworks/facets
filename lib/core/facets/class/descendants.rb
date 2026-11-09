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
  # Ruby 4.1 adds its own Module#descendants. Where Ruby has it, a call
  # without a limit is passed to Ruby's, and Facets only handles the
  # generations limit. Ruby doesn't define the order of its list.
  #
  # On older Rubies, the list is in the same order as ActiveSupport's
  # Class#descendants: the subclasses first, then each one's own
  # descendants.
  #
  # The generations walk goes through #subclasses only, never #descendants,
  # because ActiveSupport wraps #descendants in a version that takes no
  # argument.
  #
  # NOTE: With ActiveSupport loaded, calling descendants with an argument
  # raises ArgumentError, because of that wrapper.
  #
  # NOTE: This is a intensive operation. Do not expect it to be very fast.
  #
  # @author Roger Pack
  def descendants(generations=-1)
    return super() if generations < 1 && Module.method_defined?(:descendants)
    walk = lambda do |klass, gen|
      subs = klass.subclasses
      next subs if gen == 1
      subs + subs.flat_map { |k| walk.(k, gen - 1) }
    end
    walk.(self, generations)
  end

end
