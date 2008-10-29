class Module

  # Automatically generate sorting defintions base on attribute fields.
  #
  #   sort_on :a, :b
  #
  # _is equivalent to_
  #
  #   def <=>(o)
  #     cmp = self.a <=> o.a; return cmp unless cmp == 0
  #     cmp = self.b <=> o.b; return cmp unless cmp == 0
  #     0
  #   end
  #
  # TO BE DEPRECATED

  def compare_on(*fields)
    code = %{def <=>(o)\n}
    fields.each { |f|
      code << %{cmp = ( @#{f} <=> o.instance_variable_get('@#{f}') );
                return cmp unless cmp == 0\n}
    }
    code << %{0\nend; alias_method :cmp, :<=>;}
    class_eval( code )
    fields
  end

  # Should this be a standard alias?
  alias_method :sort_on, :compare_on

  # Deprecated usage
  #alias_method :sort_attributes, :sort_on

end

