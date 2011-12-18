class Array

  # Returns the value previous to the given value. The value previous
  # to the first is the last. Returns nil if the given value is not
  # in the array.
  #
  # Examples
  #
  #   sequence = ['a', 'b', 'c']
  #   sequence.before('a')           #=> 'c'
  #   sequence.before('b')           #=> 'a'
  #   sequence.before('c')           #=> 'b'
  #   sequence.before('d')           #=> nil
  #
  # CREDIT: Tyler Rick
  def before(value)
    return nil unless include? value
    self[(index(value).to_i - 1) % length]
  end

  # Returns the value after the given value. The value before the last
  # is the first. Returns nil if the given value is not in the array.
  #
  # Examples
  #
  #   sequence = ['a', 'b', 'c']
  #   sequence.after('a')           #=> 'b'
  #   sequence.after('b')           #=> 'c'
  #   sequence.after('c')           #=> 'a'
  #   sequence.after('d')           #=> nil
  #
  # CREDIT: Tyler Rick
  def after(value)
    return nil unless include? value
    self[(index(value).to_i + 1) % length]
  end

end

