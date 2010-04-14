module Kernel
  # Override this in a child class if it cannot be dup'ed.
  #
  # CREDIT: Dan Kubb (extlib)
  def try_dup
    dup
  end

  # Alternative name for #try_dup.
  # This will eventually be deprecated.
  def dup!
    try_dup
  end
end

class TrueClass
  # Since TrueClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  def try_dup
    self
  end
end

class FalseClass
  # Since FalseClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  def try_dup
    self
  end
end

class NilClass
  # Since NilClass is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  def try_dup
    self
  end
end

class Numeric
  # Since Numeric is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  def try_dup
    self
  end
end

class Symbol
  # Since Symbol is immutable it cannot be duplicated.
  # For this reason #try_dup returns +self+.
  def try_dup
    self
  end
end

#class Module
#  # Since Module is immutable it cannot be duplicated.
#  # For this reason #try_dup returns +self+.
#  def try_dup
#    self
#  end
#end

