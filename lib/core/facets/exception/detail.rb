class Exception

  # Pretty string output of exception/error
  # object useful for helpful debug messages.
  #
  # Input:
  # The Exception/StandardError object
  #
  # Output:
  # The pretty printed string
  #
  # CREDIT: George Moschovitis

  def detail
    if backtrace
      %{#{self.class.name}: #{message}\n  #{backtrace.join("\n  ")}\n  LOGGED FROM: #{caller[0]}}
    else
      %{#{self.class.name}: #{message}\n  LOGGED FROM: #{caller[0]}}
    end
  end

end

