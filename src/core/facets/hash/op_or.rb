class Hash

  # Operator for #reverse_merge.
  #
  # CREDIT: Trans

  def |(other)
    other.merge(self)
  end

end

