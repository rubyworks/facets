class Regexp

  # Useful to pass a Regexp as a block that will match elements
  #
  # %w[ joe_the_dog mary_the_cat ].index &/cat/  #=> 1
  #
  # Returns [Proc] which passes it's argument to Regexp#match method.

  def to_proc
    proc { |x| match(x) }
  end

end
