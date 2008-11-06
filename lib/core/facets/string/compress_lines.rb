class String

  # Matches any whitespace (including newline) and replaces with a single space
  #
  # @example
  #   <<-QUERY.compress_lines
  #     SELECT name
  #     FROM users
  #   QUERY
  #   => "SELECT name FROM users"
  #
  def compress_lines(spaced = true)
    split($/).map { |line| line.strip }.join(spaced ? ' ' : '')
  end

end

