class Module

  # <em>Note: the following documentation uses "class" because it's more common, but it
  # applies to modules as well.</em>
  #
  # Given the _name_ of a class, returns the class itself (i.e. instance of Class).  The
  # dereferencing starts at Object.  That is,
  #
  #   Class.by_name("String")
  #
  # is equivalent to
  #
  #   Object.const_get("String")
  #
  # The parameter _name_ is expected to be a Symbol or String, or at least to respond to
  # <tt>to_str</tt>.
  #
  # An ArgumentError is raised if _name_ does not correspond to an existing class.  If _name_
  # is not even a valid class name, the error you'll get is not defined.
  #
  # Examples:
  #
  #   Class.by_name("String")             # -> String
  #   Class.by_name("::String")           # -> String
  #   Class.by_name("Process::Sys")       # -> Process::Sys
  #   Class.by_name("GorillaZ")           # -> (ArgumentError)
  #
  #   Class.by_name("Enumerable")         # -> Enumerable
  #   Module.by_name("Enumerable")        # -> Enumerable
  #
  #  CREDIT: Gavin Sinclair

  def self.by_name(name)
    #result = Object.constant(name)
    # TODO: Does self need to be Object in the following lines?
    const  = name.to_s.dup
    base   = const.sub!(/^::/, '') ? Object : ( self.kind_of?(Module) ? self : self.class )
    result = const.split(/::/).inject(base){ |mod, subconst| mod.const_get(subconst) }

    return result if result.kind_of?( Module )
    raise ArgumentError, "#{name} is not a module or class"
  end

end


=begin test

  def test_by_name
    c = ::Test::Unit::TestCase.name
    assert_equal( ::Test::Unit::TestCase, Module.by_name(c) )
    c = "Test::Unit::TestCase"
    assert_equal( ::Test::Unit::TestCase, Class.by_name(c) )
  end

=end
