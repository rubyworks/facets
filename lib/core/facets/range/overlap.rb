class Range

  # Do two ranges overlap?
  #
  #   CREDIT: Daniel Schierbeck
  #   CREDIT: Brandon Keepers

  def overlap?(other)
    include?(other.first) or other.include?(first)
  end

end

