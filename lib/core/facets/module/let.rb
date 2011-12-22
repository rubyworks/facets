class Module

  # Create a memoized method. This method has been popularized by RSpec.
  #
  #   class LetExample
  #     let(:seed) { rand }
  #   end
  #
  #   eg = LetExample.new
  #   eg.seed == eg.seed
  #
  # CREDIT: Howard Yeh
  #
  # @uncommon
  #   require 'facets/module/let'
  #
  def let(var,&block)
    name = "@#{var}"
    self.class_eval do
      define_method(var) do
        if instance_variable_defined?(name)
          instance_variable_get(name)
        else
          val = self.instance_eval(&block)
          instance_variable_set(name,val)
        end
      end
    end
  end

end
