class Hash

  # Can be used like update, or passed
  # as two-element [key,value] array.
  #
  # CREDIT: Trans

  def <<(other)
    if other.respond_to?(:to_ary)
      store(*other)
    else
      update(other)
    end
    self
  end

  #def <<(pairs)
  #  if Array === pairs
  #    merge! Hash[*pairs]
  #  else
  #    merge! pairs
  #  end
  #end

end
