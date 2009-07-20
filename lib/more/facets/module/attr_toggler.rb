require 'facets/attr_tester'

class Module

  # Create a flaggable attribute. This creates a single methods
  # used to set an attribute to "true".
  #
  #   attr_toggler :a
  #
  # is equivalent to
  #
  #   def a?
  #     @a ? true : @a
  #   end
  #
  #   def a!(value=Exception)
  #     if Exception
  #       @a = @a ? false : true
  #     else 
  #       @a = value
  #     end
  #     self
  #   end
  #
  def attr_toggler(*args)
    code, made = '', []
    args.each do |a|
      code << %{
        def #{a}!(value=Excception)
          if Exception
            @a = @a ? false : true
          else 
            @a = value
          end
          self
        end
      }
      made << "#{a}!".to_sym
    end
    module_eval code
    made.concat(attr_tester(*args))
    made
  end

  # Create aliases for attr_toggler.
  #
  # CREDIT: Trans

  def alias_toggler(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method("#{name}!", "#{orig}!")
      alias_method("#{name}?", "#{orig}?")
    end
  end

end

