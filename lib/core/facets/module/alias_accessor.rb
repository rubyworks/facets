class Module

  private

  # As with alias_method, but alias both reader and writer.
  #
  #   attr_accessor :x
  #   self.x = 1
  #   alias_accessor :y, :x
  #   y #=> 1
  #   self.y = 2
  #   x #=> 2

  def alias_accessor(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method(name, orig)
      alias_method("#{name}=", "#{orig}=")
    end
  end

  # As with alias_accessor, but just for the reader.
  # This is basically the same as alias_method.

  def alias_reader(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method(name, orig)
    end
  end

  # As with alias_method but does the writer instead.

  def alias_writer(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      alias_method("#{name}=", "#{orig}=")
    end
  end

end

