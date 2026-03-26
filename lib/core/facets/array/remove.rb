class Array
  # Returns a new array that is a copy of the original array, removing the first occurrence of any
  # item that also appears in +other_ary+. The order is preserved from the original array.
  #
  # If there are multiple occurrences of an item in +other_ary+, this removes that many occurrences
  # from self.
  #
  # This is similar to `Array#-` and `Array#difference`, except that instead of removing _all_
  # matches, it only removes as many occurrences as there are in the +other_ary+:
  #
  #    > [1, 1, 2].remove [1]
  #   => [1, 2]
  #
  #    > [1, 1, 2].remove [1, 1, 1]
  #   => [2]
  #
  #    > [1, 1, 2] - [1]
  #   => [2]
  #
  #    > [1, 1, 2].difference [1]
  #   => [2]
  #
  def remove(other_ary)
    dup.remove!(other_ary)
  end

  # For each element of `other_ary`, deletes the _first_ element from self that is equal to that element
  # (using `delete_at`, not `delete`).
  #
  # This is the in-place version of remove.
  #
  def remove!(other_ary)
    other_ary.each do |el|
      delete_first(el)
    end
    self
  end
end
