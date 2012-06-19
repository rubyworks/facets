class NilClass

  def to_proc
    Proc.new{ |*a| a }
  end

end

