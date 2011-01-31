class Hash

  # Like merge operator '+' but merges in reverse order.
  #
  #   h1 = {:a=>1}
  #   h2 = {:a=>2, :b=>3}
  #
  #   (h1 + h2) #=> { :a=>2, :b=>3 }
  #   (h1 * h2)  #=> { :a=>1, :b=>3 }
  #
  # CREDIT: Trans

  def *(other)
    other.merge(self)
  end

end

