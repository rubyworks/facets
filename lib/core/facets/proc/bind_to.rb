class Proc

  # Bind a procedure to an object. This works by
  # wrapping instance_eval on the Proc object and
  # then wrapping this in a new Proc.
  #
  #    a = [1,2,3]
  #    p1 = Proc.new{ join(' ') }
  #    p2 = p1.bind_to(a)
  #    p2.call  #=> '1 2 3'
  #
  def bind_to(object)
    Proc.new{object.instance_eval(&self)}
  end

end

