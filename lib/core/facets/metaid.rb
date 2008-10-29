module Kernel

  # Alias a method defined in the metaclass (ie. singleton class).
  #
  #   def X.y?; "y?" ; end
  #   X.meta_alias "ynot?", "y?"
  #   X.ynot?  #=> y?
  #
  #  CREDIT: Trans

  def meta_alias(*args)
    meta_class do
      alias_method(*args)
    end
  end

  # Evaluate code in a metaclass. This is equivalent to
  # 'meta_class.instance_eval'.
  #
  #  CREDIT: WhyTheLuckyStiff

  def meta_eval(str=nil, &blk)
    if str
      meta_class.instance_eval(str)
    else
      meta_class.instance_eval(&blk)
    end
  end

  # Add method to a meta-class --i.e. a singleton method.
  #
  #   class X; end
  #   X.meta_def(:x){"x"}
  #   X.x  #=> "x"
  #
  #  CREDIT: WhyTheLuckyStiff

  def meta_def( name, &block )
    meta_class do
      define_method( name, &block )
    end
  end

  # Easy access to an object's "special" class,
  # otherwise known as it's metaclass or singleton class.

  def meta_class(&block)
    if block_given?
      (class << self; self; end).class_eval(&block)
    else
      (class << self; self; end)
    end
  end

  alias_method :metaclass, :meta_class

  # During this trying time when no one can get their
  # techie catchwords to stick to the refrigerator no
  # matter how hard they slap it # with the enchanted
  # magnetic spatula, it’s good to know that the
  # contrived phrases really do fly, graceful and
  # unclasped and bearing north toward chilled shrimp.
  # I know what my Hallowe’en pumpkin is going to say.
  #
  #                       -- why the lucky stiff
  #
  #   CREDIT: WhyTheLuckyStiff

  def eigenclass
    (class << self; self; end)
  end

end


class Module

  # Defines an instance method within a class.
  #
  #   CREDIT: WhyTheLuckyStiff

  def class_def name, &blk
    class_eval { define_method name, &blk }
  end

  protected :attr
  protected :attr_reader
  protected :attr_writer
  protected :attr_accessor
  protected :remove_method
  protected :undef_method

end

