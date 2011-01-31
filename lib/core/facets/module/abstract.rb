class Module

  # Create an abstract method. If it is not overridden, it will
  # raise a TypeError when called.
  #
  #   class AbstractExample
  #     abstract :a
  #   end
  #
  #   c = AbstractExample.new
  #
  #   expect TypeError do
  #     c.a
  #   end
  #
  # CREDIT: Trans

  def abstract(*sym)
    sym.each do |s|
      define_method(s){ raise TypeError, "undefined abstraction ##{s}" }
    end
  end

end
