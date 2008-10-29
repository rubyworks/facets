class Hash

  # Can be used like update, or passed
  # as two-element [key,value] array.
  #
  #   CREDIT: Trans

  def <<(other)
    if other.respond_to?(:to_ary)
      self.store(*other)
    else
      update(other)
    end
    self
  end

end
