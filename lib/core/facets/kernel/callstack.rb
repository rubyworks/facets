module Kernel

  alias_method :pp_callstack, :caller
  alias_method :pp_call_stack, :caller

  # Returns the call stack as an array of [file, lineno, method] entries.
  #
  # For example, from irb
  #
  #     callstack(1)
  #
  # _produces_ ...
  #
  #     [["(irb)", 2, :irb_binding], ...]
  #
  # CREDIT: Trans

  def callstack(level = 1)
    caller_locations(level).map do |loc|
      [loc.path, loc.lineno, loc.label&.to_sym]
    end
  end

  alias_method :call_stack, :callstack

end


class Binding

  # Returns the call stack, in array format.
  def callstack(level=1)
    eval( "callstack( #{level} )" )
  end

  alias_method :call_stack, :callstack
end
