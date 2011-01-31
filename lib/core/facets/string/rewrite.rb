class String

  # Apply a set of rules in the form of regular expression matches
  # to the string.
  #
  # * rules - The array containing rule-pairs (match, write).
  #
  # Keep in mind that the order of rules is significant.
  #
  # Returns the rewritten String.
  #
  # CREDIT: George Moschovitis

  def rewrite(rules)
    raise ArgumentError.new('The rules parameter is nil') unless rules
    rewritten_string = dup
    rules.each do |(match,write)|
      rewritten_string.gsub!(match,write)
    end
    return rewritten_string
  end

end

