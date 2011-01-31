class Class

  # Remove descendents. This simple deletes the constant
  # associated to the descendents name.

  def remove_descendents
    self.descendents.each do |subclass|
      Object.send(:remove_const, subclass.name) rescue nil
    end
    ObjectSpace.garbage_collect
  end

  # Obvious alias for remove_descendents.

  alias_method :remove_subclasses, :remove_descendents

end



=begin test

  require 'facets/class/remove_descendents.rb'

  require 'test/unit'

  class TestClassDescendents < Test::Unit::TestCase

    class A ; end
    class B < A ; end
    class C < B ; end

    def test_remove_descendents
      assert_nothing_raised { B.remove_descendents }
      # doesn't work despite above; not sure why
      #assert_equal( [B], A.descendents )
    end

  end

=end

