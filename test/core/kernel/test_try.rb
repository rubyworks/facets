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

end
