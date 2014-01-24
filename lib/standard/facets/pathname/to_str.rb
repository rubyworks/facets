class Pathname

  # Alias #to_s to #to_str when #to_str is not defined.
  #
  # Returns [String]
  alias_method(:to_str, :to_s) unless method_defined?(:to_str)

end
