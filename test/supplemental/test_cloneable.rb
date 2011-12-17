require 'facets/cloneable'

test_case Cloneable do

  foo = Class.new do
    include Cloneable
    def initialize
      @bar=[]
    end
    def bar_id
      @bar.object_id
    end
  end

  method :dup do
    test do
      a=foo.new
      b=a.dup
      assert_not_equal a.bar_id,b.bar_id
    end

    test do
      a=foo.new
      a.taint
      b=a.dup
      assert b.tainted?, "b should be tainted"
    end

    test do
      a=foo.new
      a.freeze
      b=a.dup
      assert !b.frozen?, "b should not be frozen"
    end
  end

  method :clone do
    test do
      a=foo.new
      b=a.clone
      assert(a.bar_id != b.bar_id, "should not be equal")
    end

    test do
      a=foo.new
      a.taint
      b=a.dup
      assert b.tainted?, "b should be tainted"
    end

    test do
      a=foo.new
      a.freeze
      b=a.clone
      assert b.frozen?, "b should be frozen"
    end

  end

end
