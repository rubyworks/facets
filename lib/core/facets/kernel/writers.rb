module Kernel

  # Returns an Array of methods ending in '='.
  #
  #   class WritersExample
  #     attr_reader :a, :b
  #     attr_accessor :x, :y
  #     private
  #     def q=(q); @q=q; end
  #   end
  #
  #   we = WritersExample.new
  #
  #   we.writers  #=> [:x=, :y=]
  #
  # If the +chomp+ option is true, then the trailing '=' will be removed.
  #
  #   we.writers(:chomp=>true)  #=> [:y, :x]
  #
  # By default #writers only includes public methods. To see private or
  # protected methods use the +:access+ option.
  #
  #   we.writers(:access=>:private)  #=> [:q=]
  #
  # Or multiple access options,
  #
  #   we.writers(:access=>[:public,:private])  #=> [:x=,:y=,:q=]
  #
  # You can simply supply `:all` to get all method regardless accessibility.
  #
  # Also, by default this method excludes all writers defined in Object 
  # or Kernel. To include these set +ancestors+ to Object or Kernel.
  #
  #   we.writers(Object)
  #
  # TODO: Create Module#instance_writers.

  def writers(*ancestors_and_options)
    options   = (Hash === ancestors_and_options.last ? ancestors_and_options.pop : {})
    chomp     = options[:chomp]
    access    = options[:access]
    ancestors = ancestors_and_options.first

    access = [access].flatten
    if access.include?(:all)
      access.concat([:public, :protected, :private])
    end
    access << :public if access.empty?

    writers = []

    if access.include?(:private)
      writers += private_methods(ancestors).select{ |m| /=$/ =~ m.to_s  }
    end

    if access.include?(:protected)
      writers += protected_methods(ancestors).select{ |m| /=$/ =~ m.to_s  }
    end

    if access.include?(:public)
      writers += public_methods(ancestors).select{ |m| /=$/ =~ m.to_s  }
    end

    if ancestors == Kernel
      exclude = nil
    elsif ancestors == Object
      exclude = Kernel
    else
      exclude = Object
    end

    if exclude
      kernel_writers = exclude.instance_methods.select{ |m| /=$/ =~ m.to_s  }
      writers = writers - kernel_writers
    end

    writers = writers.map{ |w| w.to_s.chomp('=') } if chomp
    writers.map{ |w| w.to_sym }
  end

end
