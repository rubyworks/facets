class Module

  private

  # Redirect methods to other methods. This simply
  # defines methods by the name of a hash key which
  # calls the method with the name of the hash's value.
  #
  #   class Example
  #     redirect_method :hi => :hello, :hey => :hello
  #     def hello(name)
  #       puts "Hello, #{name}."
  #     end
  #   end
  #
  #   e = Example.new
  #   e.hello("Bob")    #=> "Hello, Bob."
  #   e.hi("Bob")       #=> "Hello, Bob."
  #   e.hey("Bob")      #=> "Hello, Bob."
  #
  # The above class definition is equivalent to:
  #
  #   class Example
  #     def hi(*args)
  #       hello(*args)
  #     end
  #     def hey(*args)
  #       hello(*args)
  #     end
  #     def hello
  #       puts "Hello"
  #     end
  #   end
  #
  # CREDIT: Trans

  def redirect_method( method_hash )
    method_hash.each do |targ,adv|
      define_method(targ) { |*args| send(adv,*args) }
    end
  end

  alias_method :redirect, :redirect_method

end
