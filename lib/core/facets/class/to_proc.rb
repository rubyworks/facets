class Class

  # Convert instatiation of a class into a Proc.
  #
  #   class Person
  #     def initialize(name)
  #       @name = name
  #     end
  #
  #     def inspect
  #       @name.to_str
  #     end
  #   end
  #
  #   persons = %w(john bob jane hans).map(&Person)
  #
  #   persons.map{ |p| p.inspect }  #=> ['john', 'bob', 'jane', 'hans']
  #
  # CREDIT: Daniel Schierbeck
  def to_proc
    proc{|*args| new(*args)}
  end

end

