class Module

  unless method_defined?(:set)

    # Sets an option to the given value. If the value is a proc,
    # the proc will be called every time the option is accessed.
    #
    # CREDIT: ? (Sinatra)

    def set(option, value=self, &block)
      raise ArgumentError if block && value != self
      value = block if block
      if value.kind_of?(Proc)
        if value.arity == 1
          yield self
        else
          (class << self; self; end).module_eval do
            define_method(option, &value)
            define_method("#{option}?"){ !!__send__(option) }
            define_method("#{option}="){ |val| set(option, Proc.new{val}) }
          end
        end
      elsif value == self
        option.each{ |k,v| set(k, v) }
      elsif respond_to?("#{option}=")
        __send__("#{option}=", value)
      else
        set(option, Proc.new{value})
      end
      self
    end

  end

end

