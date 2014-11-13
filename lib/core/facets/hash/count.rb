class Hash

  # Like Enumerable#count, but can count hash values.
  #
  #   {:A=>1, :B=>1}.count(1)  #=> 2
  #
  def count(value=nil)
    if value
      values.count(value)
    else
      super()
    end
  end

end

