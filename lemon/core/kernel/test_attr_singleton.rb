Covers 'facets/kernel/attr_singleton'

Case Kernel do

  # Fixture :AttrSingletonMock
  class AttrSingletonMock
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

  Unit :attr_singleton_reader do
    t = AttrSingletonMock.new
    t.foo.assert == "FOO"
  end

  Unit :attr_singleton_writer do
    t = AttrSingletonMock.new
    t.get_bar.assert == "BAR"
    t.bar = "BAR2"
    t.get_bar.assert == "BAR2"
  end

  Unit :attr_singleton_accessor do
    t = AttrSingletonMock.new
    t.baz.assert == "BAZ"
    t.baz = "BAZ2"
    t.baz.assert == "BAZ2"
  end

end

