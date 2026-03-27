class Exception

  # @deprecated Use Exception#full_message instead (built-in since Ruby 2.5).
  def self.error_print(e)
    warn "Exception.error_print is deprecated. Use Exception#full_message instead.", uplevel: 1
    e.full_message
  end

  # @deprecated Use Exception#full_message instead (built-in since Ruby 2.5).
  def error_print
    warn "Exception#error_print is deprecated. Use Exception#full_message instead.", uplevel: 1
    full_message
  end

end
