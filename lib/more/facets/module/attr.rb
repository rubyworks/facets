class Module

  # Create a toggle attribute. This creates two methods for
  # each given name. One is a form of tester and the other
  # is used to toggle the value.
  #
  #   attr_accessor! :a
  #
  # is equivalent to
  #
  #   def a?
  #     @a
  #   end
  #
  #   def a!(value=true)
  #     @a = value
  #     self
  #   end
  #
  # CREDIT: Trans

  def attr_switch_accessor(*args)
    attr_reader!(*args) + attr_writer!(*args)
  end

  alias_method :attr_toggler,  :attr_accessor!

  # Create aliases for flag accessors.
  #
  # CREDIT: Trans

  def alias_accessor!(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method("#{name}?", "#{orig}?")
      alias_method("#{name}!", "#{orig}!")
    end
  end
  alias_method :alias_switcher, :alias_accessor!
  alias_method :alias_toggler,  :alias_accessor!

  # Create a flaggable attribute. This creates a single methods
  # used to set an attribute to "true".
  #
  #   attr_writer! :a
  #
  # is equivalent to
  #
  #   def a!(value=true)
  #     @a = value
  #     self
  #   end
  #
  def attr_writer!(*args)
    code, made = '', []
    args.each do |a|
      code << %{
        def #{a}!(value=true)
          @#{a} = value
          self
        end
      }
      made << "#{a}!".to_sym
    end
    module_eval code
    made
  end

  # Create aliases for flag writer.
  #
  # CREDIT: Trans

  def alias_writer!(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method("#{name}!", "#{orig}!")
    end
  end

end

