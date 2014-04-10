class Proc

  # Wrap the argument in a proc. Simply returns the argument if it is
  # already a Proc object.
  #
  # TODO: Would this make more sense as `Kernel#Proc()` method,
  #        akin to `Integer()` and the like?
  #
  # Returns [Proc]
  #
  # Credit: Sean Mackesey

  def self.wrap(arg)
    Proc === arg ? arg : Proc.new{ arg }
  end

end
