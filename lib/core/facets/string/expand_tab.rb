class String

  # Expands tabs to +n+ spaces. Non-destructive. If +n+ is 0,
  # then tabs are simply removed. Raises an exception if +n+
  # is negative.
  #
  #   "\t\tHey".expand_tabs(2)  #=> "    Hey"
  #
  # Thanks to GGaramuno for a more efficient algorithm. Very nice.
  #
  # CREDIT: Gavin Sinclair, Noah Gibbs, GGaramuno
  #
  # TODO: Don't much care for the name String#expand_tabs.
  # What about a more concise name like #detab?

  def expand_tabs(n=8)
    n = n.to_int
    raise ArgumentError, "n must be >= 0" if n < 0
    return gsub(/\t/, "") if n == 0
    return gsub(/\t/, " ") if n == 1
    str = self.dup
    while
      str.gsub!(/^([^\t\n]*)(\t+)/) { |f|
        val = ( n * $2.size - ($1.size % n) )
        $1 << (' ' * val)
      }
    end
    str
  end

  # Singular form of #expand_tabs.
  alias_method :expand_tab, :expand_tabs

end

