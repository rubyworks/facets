class Module

  private

  # Creates a new method for a pre-existing method.
  #
  # If _aka_ is given, then the method being redefined will
  # first be aliased to this name.
  #
  #   class Greeter
  #     def hello ; "Hello" ; end
  #   end
  #
  #   Greeter.new.hello   #=> "Hello"
  #
  #   class Greeter
  #     redefine_method( :hello, :hi ) do
  #       hi + ", friend!"
  #     end
  #   end
  #
  #   Greeter.new.hello   #=> "Hello, friend!"
  #
  #  CREDIT: Trans

  def redefine_method(sym, aka=nil, &blk)
    raise ArgumentError, "method does not exist" unless method_defined?( sym )
    alias_method( aka, sym ) if aka
    undef_method( sym )
    define_method( sym, &blk )
  end

  alias_method :redef, :redefine_method

end
