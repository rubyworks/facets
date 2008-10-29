class Range

  # A thing really should know itself.
  # This simply returns _self_.
  #
  # CREDIT: Trans

  def to_r
    self
  end

  # A thing really should know itself.
  # This simply returns _self_.
  #
  # Note: This does not internally effect the Ruby
  # interpretor such that it can coerce Range-like
  # objects into a Range.
  #
  # CREDIT: Trans

  def to_range
    self
  end

end

