class Hash

  # Like Enumerable#count, but counts hash values.
  #
  #   {:A=>1, :B=>1}.count(1) #=> 2
  #
  def count(value)
    values.count(value)
  end

end

