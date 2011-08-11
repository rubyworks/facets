covers 'facets/kernel/attr_singleton'

test_case Kernel do

  c = Class.new do
    def initialize
      attr_singleton_reader :foo #=> "FOO"
      attr_singleton_writer :bar #=> "BAR"
      attr_singleton_accessor :baz #=> "BAZ"
      @foo = "FOO"
      self.bar = "BAR"
      self.baz = "BAZ"
    end
    def get_bar
      @bar
    end
  end

  method :attr_singleton_reader do

    test do
      t = c.new
      t.foo.assert == "FOO"
    end

  end

  method :attr_singleton_writer do

    test do
      t = c.new
      t.get_bar.assert == "BAR"
      t.bar = "BAR2"
      t.get_bar.assert == "BAR2"
    end

  end

  method :attr_singleton_accessor do

    test do
      t = c.new
      t.baz.assert == "BAZ"
      t.baz = "BAZ2"
      t.baz.assert == "BAZ2"
    end

  end

end

