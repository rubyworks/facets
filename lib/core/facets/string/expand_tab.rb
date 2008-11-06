class String

  # Expands tabs to +n+ spaces. Non-destructive. If +n+ is 0,
  # then tabs are simply removed. Raises an exception if +n+
  # is negative.
  #
  #   "\t\tHey".expand_tab(2)  #=> "    Hey"
  #
  # Thanks to GGaramuno for a more efficient algorithm. Very nice.
  #
  # CREDIT: Gavin Sinclair, Noah Gibbs, GGaramuno

  def expand_tab(n=8)
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

  # Pluralized form of #expand_tab.
  alias_method :expand_tabs, :expand_tab

  # NOTE: Don't much care for the name String#expand_tab.
  # What about a more concise name like #detab?

end

