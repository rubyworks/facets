class String

  # Converts a string to camelcase. This method leaves the first character
  # as given. This allows other methods to be used first, such as #uppercase
  # and #lowercase.
  #
  #   "camel_case".camelcase       #=> "camelCase"
  #   "Camel_case".camelcase       #=> "CamelCase"
  #
  # Custom +separators+ can be used to specify the divisions used to determine
  # where capitalization should occur. By default these are `_` and `-`.
  #
  #   "camel/case".camelcase('/')  #=> "camelCase"
  #
  # Note that this implementation is quite different form ActiveSupports.
  #
  def camelcase(*separators)
    separators = ['_', '-'] if separators.empty?

    str = self.dup

    separators.each do |s|
      str = str.gsub(/(?:#{s}+)([a-z])/){ $1.upcase }
    end

    str
  end

  # Same as +#camelcase+ but converts first letter to uppercase.
  #
  #   "camel_case".lowercamelcase   #=> "CamelCase"
  #   "Camel_case".lowercamelcase   #=> "camelCase"
  #
  def uppercamelcase(*separators)
    camelcase(*separators).gsub(/(\A|\s)([a-z])/){ $1 + $2.upcase }
  end

  # Same as +#camelcase+ but converts first letter to lowercase.
  #
  #   "camel_case".uppercamelcase   #=> "camelCase"
  #   "Camel_case".uppercamelcase   #=> "CamelCase"
  #
  def lowercamelcase(*separators)
    camelcase(*separators).gsub(/(\A|\s)([A-Z])/){ $1 + $2.downcase }
  end

  alias_method :upper_camelcase, :uppercamelcase
  alias_method :lower_camelcase, :lowercamelcase

end

