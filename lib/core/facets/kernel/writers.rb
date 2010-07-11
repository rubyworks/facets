module Kernel

  # Returns an Array of methods ending in '='.
  #
  #   class WritersExample
  #     attr_reader :a, :b
  #     attr_accessor :x, :y
  #   end
  #
  #   we = WritersExample.new
  #
  #   we.writers              # -> [:x=, :y=]
  #   we.writers(true, true)  # -> [:y, :x]
  #
  # By default this methoid excludes all writers defined in Object or Kernel.
  # To include these set +ancestors+ to Object or Kernel.
  #
  #   we.writers(Object)
  #
  # TODO: This method could use a bit of refinement with respect to
  # prublic, private and protected visibility.
  def writers(ancestors=false, chomp=false)
    writers = public_methods(ancestors).select{ |m| /=$/ =~ m.to_s  }

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

