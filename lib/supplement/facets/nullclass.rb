# = Nullclass
#
# NullClass is essentially NilClass but it differs in one
# important way. When a method is called against it that it
# deoesn't have, it will simply return null value rather then
# raise an error.
#
# TODO: Perhaps NullClass should be called NackClass?

class NullClass #< NilClass
  class << self
    def new
      @null ||= NullClass.allocate
    end
  end
  def inspect ; 'null' ; end
  def nil?  ; true ; end
  def null? ; true ; end
  def [](key); nil; end
  def method_missing(sym, *args)
    return nil if sym.to_s[-1,1] == '?'
    self
  end
end

module Kernel
  def null
    NullClass.new
  end
end

class Object
  def null?
    false
  end
end

# Copyright (c) 2005 Thomas Sawyer
