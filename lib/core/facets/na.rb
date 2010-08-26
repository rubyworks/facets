
# N/A exception is useful for specifying non-argument defaults when +nil+
# is a valid value.
#
#   def f(x=NA)
#   end
#
# NA is also used to represent an argument "slot" for Proc#partial.
#
# NA is a subclass of ArgumentError.

class NA < ArgumentError
end

