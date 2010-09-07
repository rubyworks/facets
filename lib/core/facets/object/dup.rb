require 'facets/kernel/try_dup'

class Object  # module Kernel ?
  # Override this in a child class if it cannot be dup'ed.
  #
  #   obj1 = Object.new
  #   obj2 = obj1.dup!
  #   obj2.equal?(obj1)    #=> false
  #
  # CREDIT: Dan Kubb (extlib)
  def dup!
    dup
  end

  # Alternative name for #dup!
  def try_dup
    dup!
  end

  # Can you safely call #dup on this object?
  #
  # Returns +false+ for +nil+, +false+, +true+, symbols, and numbers;
  # +true+ otherwise.
  def dup?   ; true ; end
  def clone? ; true ; end
end

class NilClass
  # Since NilClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   nil.dup!  #=> nil
  #
  def dup!   ; self  ; end
  def dup?   ; false ; end
  def clone? ; false ; end
end

class FalseClass
  # Since FalseClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   false.dup!  #=> false
  #
  def dup!   ; self  ; end
  def dup?   ; false ; end
  def clone? ; false ; end
end

class TrueClass
  # Since TrueClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   true.dup!  #=> true
  #
  def dup!   ; self  ; end
  def dup?   ; false ; end
  def clone? ; false ; end
end

class Symbol
  # Since Symbol is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   :a.dup!  #=> :a
  #
  def dup!   ; self  ; end
  def dup?   ; false ; end
  def clone? ; false ; end
end

class Numeric
  # Since Numeric is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   1.dup!  #=> 1
  #
  def dup!   ; self  ; end
  def dup?   ; false ; end
  def clone? ; false ; end
end
