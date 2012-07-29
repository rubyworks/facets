class NilClass

  # Allows `nil` to create an empty hash,
  # similar to #to_a and #to_s.
  #
  #   nil.to_h    #=> {}
  #
  # CREDIT: Trans

  def to_h
    {}
  end \
  unless method_defined?(:to_h)  # Ruby 2.0.0

end

