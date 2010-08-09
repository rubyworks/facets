class Module

  # Generates identity/key methods based on specified accessors.
  #
  #  equate_on :a, :b
  #
  # _is equivalent to_
  #
  #   def ==(o)
  #     self.a == o.a && self.b == o.b
  #   end
  #
  #   def eql?(o)
  #     self.a.eql?(o.a) && self.b.eql?(o.b)
  #   end
  #
  #   def hash()
  #     self.a.hash ^ self.b.hash
  #   end
  #
  # TO BE DEPRECTED (This was usurped by Equatable.)

  def equate_on(*fields)
    code = ""
    code << "def ==(o) "   << fields.map {|f| "self.#{f} == o.#{f}" }.join(" && ")    << " end\n"
    code << "def eql?(o) " << fields.map {|f| "self.#{f}.eql?(o.#{f})" }.join(" && ") << " end\n"
    code << "def hash() "  << fields.map {|f| "self.#{f}.hash" }.join(" ^ ")          << " end\n"
    class_eval( code )
    fields
  end

  # Deprecated.
  #alias_method :key_attributes, :equate_on

end

