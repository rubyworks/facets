module Kernel
  # Override this in a child class if it cannot be dup'ed.
  #
  #   obj1 = Object.new
  #   obj2 = obj1.try_dup
  #   obj2.equal?(obj1)    #=> false
  #
  # CREDIT: Dan Kubb (extlib)
  def try_dup
    dup
  end

  # Alternative name for #try_dup.
  def dup!
    try_dup
  end
end

class TrueClass
  # Since TrueClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   true.try_dup  #=> true
  #
  def try_dup
    self
  end
end

class FalseClass
  # Since FalseClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   false.try_dup  #=> false
  #
  def try_dup
    self
  end
end

class NilClass
  # Since NilClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   nil.try_dup  #=> nil
  #
  def try_dup
    self
  end
end

class Numeric
  # Since Numeric is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   1.try_dup  #=> 1
  #
  def try_dup
    self
  end
end

class Symbol
  # Since Symbol is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  #
  #   :a.try_dup  #=> :a
  #
  def try_dup
    self
  end
end

