class Hash

  # A method to convert a Hash into a Struct.
  #
  #   h = {:name=>"Dan","age"=>33,"rank"=>"SrA","grade"=>"E4"}
  #   s = h.to_struct("Foo")
  #
  # TODO: Is this robust enough considerd hashes aren't ordered?
  #
  #  CREDIT: Daniel Berger

  def to_struct(struct_name)
    Struct.new(struct_name,*keys).new(*values)
  end

end

