class UnboundMethod

  unless method_defined?(:name) # 1.8.7+

    # Return the name of the method.
    #
    # Be aware that in ruby 1.9 UnboundMethod#name is defined already,
    # but it returns a Symbol not a String.
    #
    #   class NameExample
    #     def foo; end
    #   end
    #
    #   meth = NameExample.instance_method(:foo)
    #
    #   meth.name.to_sym  #=> :foo
    #
    # CREDIT: Trans

    def name
      i = to_s.rindex('#')
      to_s.slice(i+1...-1).to_sym
    end

  end

end

