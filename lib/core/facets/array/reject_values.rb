class Array

  # Non-destructive form of `Array#delete_values`. Unlike `delete_values`
  # this method returns a new array.
  #
  # values - List of array elements to reject.
  #
  # Examples
  #
  #     [1,2,3,4,5].reject_values(2,4)  # => [1,3,5]
  #
  # Returns [Array]
  #
  # CREDIT: Sean Mackesey

  def reject_values(*values)
    reject { |x| values.include?(x) }
  end

end

