class Module

  # Create an tester attribute. This creates a single method
  # used to test the attribute for truth.
  #
  #   attr_tester :a
  #
  # is equivalent to
  #
  #   def a?
  #     @a ? true : @a
  #   end
  #
  def attr_tester(*args)
    code, made = '', []
    args.each do |a|
      code << %{
        def #{a}?(truth=nil)
          @#{a} ? truth || @#{a} : @#{a}
        end
      }
      made << "#{a}?".to_sym
    end
    module_eval code
    made
  end

  alias_method :attr_reader?, :attr_tester

  # Create aliases for flag reader.
  #
  # CREDIT: Trans

  def alias_tester(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method("#{name}?", "#{orig}?")
    end
  end
  alias_method :alias_reader?, :alias_tester

end

