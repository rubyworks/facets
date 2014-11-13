class Hash

  # Like Enumerable#count, but can count hash values.
  #
  #   {:A=>1, :B=>1}.count(1)  #=> 2
  #
  def count(*value)
    if value.empty?
      super()
    else
      values.count(*value)
    end
  end

end

