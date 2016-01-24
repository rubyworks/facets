class Object

  # Return itself or a "default" in the case of nil
  #
  # Examples
  #
  #   nil.or('something') # => "something"
  #   'something'.or('nothing') # => "something"
  #
  def or(obj)
    nil? ? obj : self
  end
end



