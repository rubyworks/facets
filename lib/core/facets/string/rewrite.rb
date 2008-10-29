class String

  # Apply a set of rules (regular expression matches) to the string.
  #
  # === Requirements:
  # The rules must be applied in order! So we cannot use a
  # hash because the ordering is not guaranteed! we use an
  # array instead.
  #
  # === Input:
  # The array containing rule-pairs (match, write).
  #
  # === Output:
  # The rewritten string.
  #
  #   CREDIT: George Moschovitis

  def rewrite(rules)
    raise ArgumentError.new('The rules parameter is nil') unless rules
    rewritten_string = dup
    rules.each do |match,write|
      rewritten_string.gsub!(match,write)
    end
    return rewritten_string
  end

end

