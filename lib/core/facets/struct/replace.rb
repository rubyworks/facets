class Struct

  # Struct#replace can take any +source+ that responds to #each_pair.
  def replace(source)
    source.each_pair{ |k,v| send(k.to_s + "=", v) }
  end

end
