module Kernel
  # Override this in a child class if it cannot be dup'ed.
  #
  # CREDIT: Dan Kubb (extlib)
  def dup!
    dup
  end

  # Original name for dup! as defined by extlib.
  # This will eventually be deprecated. Use #dup! instead.
  def try_dup
    dup!
  end
end

class TrueClass
  # Since TrueClass is immutable it cannot be duplicated.
  # For this reason #dup! returns +self+.
  def dup!
    self
  end
end

class FalseClass
  # Since FalseClass is immutable it cannot be duplicated.
  # For this reason #dup! returns +self+.
  def dup!
    self
  end
end

class NilClass
  # Since NilClass is immutable it cannot be duplicated.
  # For this reason #dup! returns +self+.
  def dup!
    self
  end
end

class Numeric
  # Since Numeric is immutable it cannot be duplicated.
  # For this reason #dup! returns +self+.
  def dup!
    self
  end
end

class Symbol
  # Since Symbol is immutable it cannot be duplicated.
  # For this reason #dup! returns +self+.
  def dup!
    self
  end
end

#class Module
#  # Since Module is immutable it cannot be duplicated.
#  # For this reason #dup! returns +self+.
#  def dup!
#    self
#  end
#end

