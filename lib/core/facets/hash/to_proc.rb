class Hash

  # Constructs a Proc object from a hash such
  # that the parameter of the Proc is assigned
  # the hash keys as attributes.
  #
  #   h = { :a => 1 }
  #   p = h.to_proc
  #   o = OpenStruct.new
  #   p.call(o)
  #   o.a  #=> 1
  #
  # CREDIT: Trans

  def to_proc
    lambda do |o|
      self.each do |k,v|
        ke = "#{k}="
        o.__send__(ke, v)
      end
    end
  end

  # A fault-tolerent version of #to_proc.
  #
  # It works just like #to_proc, but the block will make
  # sure# the object responds to the assignment.
  #
  # CREDIT: Trans

  def to_proc_with_reponse
    lambda do |o|
      self.each do |k,v|
        ke = "#{k}="
        o.__send__(ke, v) if respond_to?(ke)
      end
    end
  end

end

