class Symbol

  # Generate a unique symbol.
  #
  #   Symbol.generate => :-1
  #
  # If +key+ is given the new symbol will be prefixed with it.
  #
  #   Symbol.generate(:foo) => :foo-1
  #
  #   TODO: Is the generated symbol format acceptable?
  #
  #  CREDIT: Trans

  def self.generate(key=nil)
    key = key.to_sym if key
    @symbol_generate_counter ||= {}
    @symbol_generate_counter[key] ||= 0
    num = @symbol_generate_counter[key] += 1
    ("#{key}-%X" % num).to_sym
  end

end

