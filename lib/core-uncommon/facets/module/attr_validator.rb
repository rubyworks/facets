class Module

  # Like attr_writer, but the writer method validates the
  # setting against the given block.
  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: ?

  def attr_validator(*symbols, &validator)
    made = []
    symbols.each do |symbol|
      define_method "#{symbol}=" do |val|
        unless validator.call(val)
          raise ArgumentError, "Invalid value provided for #{symbol}"
        end
        instance_variable_set("@#{symbol}", val)
      end
      made << "#{symbol}=".to_sym
    end
    made
  end

  # Create aliases for validators.
  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.

  def alias_validator(*args)
    orig = args.last
    args = args - [orig]
    args.each do |name|
      #alias_method(name, orig)
      alias_method("#{name}=", "#{orig}=")
    end
  end

end

