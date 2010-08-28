require 'facets/kernel/try_dup'

class Object  # module Kernel ?
  # Can you safely call #dup on this object?
  # False for nil, false, true, symbols, and numbers; true otherwise.
  def dup?   ; true ; end
  def clone? ; true ; end
end

class NilClass
  def dup?   ; false ; end
  def clone? ; false ; end
end

class FalseClass
  def dup?   ; false ; end
  def clone? ; false ; end
end

class TrueClass
  def dup?   ; false ; end
  def clone? ; false ; end
end

class Symbol
  def dup?   ; false ; end
  def clone? ; false ; end
end

class Numeric
  def dup?   ; false ; end
  def clone? ; false ; end
end

