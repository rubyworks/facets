class Module

  #
  def instance_method_aliases(opts={})
    list = instance_methods.group_by{|m| instance_method(m)}.map(&:last)

    if opts[:only]
      list.keep_if{|symbols| symbols.length > 1}
    end
  end

end
