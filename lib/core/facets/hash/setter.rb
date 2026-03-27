class Hash

  # Constructs a Proc that assigns the hash's key-value pairs as
  # attributes on a given object.
  #
  #   c = Class.new do
  #     attr_accessor :a
  #   end
  #
  #   h = {:a => 1}
  #   o = c.new
  #   h.setter.call(o)
  #   o.a  #=> 1
  #
  # If +safe+ is set to +true+, then assignment will only occur
  # if the receiver responds_to? the writer method.
  #
  # CREDIT: Trans

  def setter(safe=false)
    if safe
      lambda do |o|
        self.each do |k,v|
          ke = "#{k}="
          o.__send__(ke, v) if o.respond_to?(ke)
        end
      end
    else
      lambda do |o|
        self.each do |k,v|
          ke = "#{k}="
          o.__send__(ke, v)
        end
      end
    end
  end

end
