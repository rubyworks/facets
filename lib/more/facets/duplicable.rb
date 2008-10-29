# = Duplicable
#
# This is not a mixin, since nearly all objects have this baehavior.
#
# Is this the same as immutable? Whould that be a better name?

class Object
  # Can you safely .dup this object?
  # False for nil, false, true, symbols, and numbers; true otherwise.
  def duplicable?
    true
  end
end

class NilClass #:nodoc:
  def duplicable?
    false
  end
end

class FalseClass #:nodoc:
  def duplicable?
    false
  end
end

class TrueClass #:nodoc:
  def duplicable?
    false
  end
end

class Symbol #:nodoc:
  def duplicable?
    false
  end
end

class Numeric #:nodoc:
  def duplicable?
    false
  end
end
