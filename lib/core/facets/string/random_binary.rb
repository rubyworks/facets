class String

  # Generate a random binary string of +n_bytes+ size.
  #
  # CREDIT: Guido De Rosa
  def self.random_binary(n_bytes)
    ( Array.new(n_bytes){ rand(0x100) } ).pack('c*') 
  end

end
