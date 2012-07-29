class Hash

  # Return a rehashing of _self_.
  #
  #   {"a"=>1,"b"=>2}.to_h  #=> {"b"=>2,"a"=>1}
  #
  # CREDIT: Forian Gross

  def to_h
    rehash  #dup
  end \
  unless method_defined?(:to_h) # 2.0.0

  # Returns _self_.
  def to_hash
    self
  end \
  unless method_defined?(:to_hash) # 1.9.?+

end
