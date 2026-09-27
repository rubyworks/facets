covers 'facets/kernel/try'

test_case Kernel do

  method :try do

    test do
      example = Struct.new(:name).new("bob")
      example.try(:name).assert == "bob"
    end

    test "without argument" do
      example = Struct.new(:name).new("bob")
      example.try.name.assert == "bob"
    end

    test "raises for a missing method" do
      example = Struct.new(:name).new("bob")
      NoMethodError.assert.raised? { example.try(:nmae) }
    end

    test "raises for a private method, like a normal call" do
      example = Class.new { private def secret; :s; end }.new
      NoMethodError.assert.raised? { example.try(:secret) }
    end

  end

  method :try! do

    test do
      example = Struct.new(:name).new("bob")
      example.try!(:name).assert == "bob"
    end

    test "returns nil for a missing method" do
      example = Struct.new(:name).new("bob")
      example.try!(:nmae).assert == nil
    end

    test "returns nil for a private method" do
      example = Class.new { private def secret; :s; end }.new
      example.try!(:secret).assert == nil
    end

  end

end

test_case NilClass do

  method :try do

    test do
      nil.try(:name).assert == nil
    end

    test "without argument" do
      nil.try.name.assert == nil
    end

  end

  method :try! do

    test do
      nil.try!(:name).assert == nil
    end

  end

end
