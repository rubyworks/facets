class Method

  #
  # @return [Boolean]
  #   Returns true if self encapsulates a public method.
  #
  # @author Robert Gleeson
  #
  def public?
    receiver.public_methods.include? name
  end

  #
  # @return [Boolean]
  #   Returns true if self encapsulates a protected method.
  #
  # @author Robert Gleeson
  #
  def protected?
    receiver.protected_methods.include? name
  end

  #
  # @return [Boolean]
  #   Returns true if self encapsulates a private method.
  #
  # @author Robert Gleeson
  #
  def private?
    receiver.private_methods.include? name
  end

end
