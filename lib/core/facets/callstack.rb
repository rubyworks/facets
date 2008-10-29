module Kernel

  alias_method :pp_callstack, :caller

  # Parse a caller string and break it into its components,
  # returning an array. Returns:
  # * file (String)
  # * lineno (Integer)
  # * method (Symbol)
  #
  # For example, from irb,
  #
  #   call_stack(1)
  #
  # _produces_
  #
  # [["(irb)", 2, :irb_binding],
  #  ["/usr/lib/ruby/1.8/irb/workspace.rb", 52, :irb_binding],
  #  ["/usr/lib/ruby/1.8/irb/workspace.rb", 52, nil]]
  #
  # Note: If the user decides to redefine caller() to output data
  # in a different format, _prior_ to requiring this, then the
  # results will be indeterminate.
  #
  #   CREDIT: Trans

  def callstack( level = 1 )
    call_str_array = pp_callstack(level)
    stack = []
    call_str_array.each{ |call_str|
      file, lineno, method = call_str.split(':')
      if method =~ /in `(.*)'/ then
        method = $1.intern()
      end
      stack << [file, lineno.to_i, method]
    }
    stack
  end

end


class Binding

  # Returns the call stack, in array format.

  def callstack(level=1)
    eval( "callstack( #{level} )" )
  end

end

