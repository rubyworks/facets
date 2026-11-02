class Module

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
  # The new method keeps the visibility of the one it replaces. Like
  # ActiveSupport's Module#redefine_method, this is public.
  #
  # CREDIT: Trans

  def redefine_method(sym, aka=nil, &blk)
    visibility = if private_method_defined?(sym)
                   :private
                 elsif protected_method_defined?(sym)
                   :protected
                 else
                   :public
                 end
    alias_method(aka, sym) if aka
    ## prevent warning about method overwrite
    begin remove_method(sym) rescue NameError end
    ## define replacement method
    define_method(sym, &blk)
    __send__(visibility, sym)
  end

  #
  alias_method :redef, :redefine_method

end
