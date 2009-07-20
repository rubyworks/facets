class Object #:nodoc:
  # Can you safely call #dup on this object?
  # False for nil, false, true, symbols, and numbers; true otherwise.
  def dup?   ; true ; end
  def clone? ; true ; end
end

class NilClass #:nodoc:
  def dup?   ; false ; end
  def clone? ; false ; end
end

class FalseClass #:nodoc:
  def dup?   ; false ; end
  def clone? ; false ; end
end

class TrueClass #:nodoc:
  def dup?   ; false ; end
  def clone? ; false ; end
end

class Symbol #:nodoc:
  def dup?   ; false ; end
  def clone? ; false ; end
end

class Numeric #:nodoc:
  def dup?   ; false ; end
  def clone? ; false ; end
end

# :facets: extra

