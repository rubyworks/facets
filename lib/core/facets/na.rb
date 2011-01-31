# N/A exception is useful for specifying non-argument defaults when +nil+
# is a valid value.
#
#   def f(x=NA)
#   end
#
# NA is also used to represent an argument "slot" for Proc#partial.
#
# NA is an instance of ArgumentError.

class << NA = ArgumentError.new
  def inspect ; 'N/A' ; end
  def method_missing(*); self; end
end

# NA is a subclass of ArgumentError.
#class NA < ArgumentError
#  class << self
#    def method_missing(*); self; end
#  end
#end
