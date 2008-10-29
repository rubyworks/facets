class Array

  # In place #merge.
  #
  #   a = [1,2]
  #   a.merge! [2,3]
  #   a => [1,2,3]
  #
  #  CREDIT: Trans

  def merge!( other )
    self.replace(self.merge(other))
  end

  # Alias for <tt>|</tt>.
  #
  #   [1,2].merge [2,3]  #=> [1,2,3]
  alias_method :merge, :|

end

