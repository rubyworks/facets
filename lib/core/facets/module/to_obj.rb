class Module

  # Create an instance of Object and extend it with +self+.
  #
  #   mod = Module.new do
  #     def foo; "foo"; end
  #   end
  #
  #   obj = mod.to_obj
  #
  #   obj.foo #=> "foo"
  #
  def to_obj
    o = Object.new
    o.extend self
    o
  end

end

