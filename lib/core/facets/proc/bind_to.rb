class Proc

  #
  def bind_to(object)
    Proc.new{object.instance_eval(&self)}
  end

end

