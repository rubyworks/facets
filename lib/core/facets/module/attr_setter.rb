class Module

  # Create an attribute method for both getting
  # and setting an instance variable.
  #
  #   attr_setter :a
  #
  # _is equivalent to_
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
  #     attr_accessor :a
  #     alias_accessor :b, :a
  #   end
  #
  #   x = AttrSetterExample.new
  #   x.b = 1
  #   x.a        #=> 1
  #
  # CREDIT: Trans

  def alias_setter(*args)
    args = args - [orig]
    args.each do |name|
      alias_method(name, orig)
    end
  end

end

