class Module

  # Create an attribute method for both getting
  # and setting an instance variable:
  #
  #   attr_setter :a
  #
  # is equivalent to:
  #
  #   def a(*args)
  #     if args.size > 0
  #       @a = args[0]
  #       self
  #     else
  #       @a
  #     end
  #   end
  #
  # CREDIT: Trans

  def attr_setter(*args)
    code, made = '', []
    args.each do |a|
      code << %{
        def #{a}(*args)
          args.size > 0 ? ( @#{a}=args[0] ; self ) : @#{a}
        end
      }
      made << "#{a}".to_sym
    end
    module_eval code
    made
  end

  # Alias an accessor. This create an alias for
  # both a reader and a writer.
  #
  #   class AttrSetterExample
  #     attr_setter :a
  #     alias_setter :b, :a
  #   end
  #
  #   x = AttrSetterExample.new
  #   x.b = 1
  #   x.a        #=> 1
  #
  # CREDIT: Trans

  alias_method :alias_setter, :alias_method

end

