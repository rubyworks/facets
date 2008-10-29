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
  #   %w(john bob jane hans).map(&Person) => [john, bob, jane, hans]
  #
  # CREDIT: Daniel Schierbeck

  def to_proc
    proc{|*args| new(*args)}
  end

end



=begin test
  reqiure 'test/unit'

  class TestClassConversion < Test::Unit::TestCase

    Person = Struct.new(:name)

    def test_to_proc
      people = ["joe"].map(&Person)
      assert_equal("joe", people[0].name)
    end

  end

=end

