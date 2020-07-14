class Array
  # Deletes first item from +self+ that is equal to +obj+.
  #
  # Returns the deleted item, or +nil+ if no matching item is found.
  #
  # If the optional code block is given, the result of the block is returned if
  # the item is not found.
  #
  #    a = [ "a", "b", "b", "b", "c" ]
  #    a.delete_first("b")                   #=> "b"
  #    a                               #=> ["a", "c"]
  #    a.delete("z")                   #=> nil
  #    a.delete("z") {"not found"}     #=> "not found"
  def delete_first(el)
    i = index(el)
    if i
      delete_at(i)
    end
  end
end

