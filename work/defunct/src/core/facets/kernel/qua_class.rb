module Kernel

  # Easy access to an object qua class, otherwise known as the object's
  # singleton class. #qua_class can also take a block.
  #
  #   string = "Hello World"
  #
  #   string.qua_class do
  #     def important
  #        self + "!"
  #     end
  #   end
  #
  #   string.important  #=> "Hello World!"
  #
  # Yes, another one.
  #
  # CREDIT: Trans

  def qua_class(&block)
    if block_given?
      (class << self; self; end).class_eval(&block)
    else
      (class << self; self; end)
    end
  end

  # The +qua_class+ method can also be written +quaclass+.
  alias_method :quaclass, :qua_class

end
