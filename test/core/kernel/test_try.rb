covers 'facets/kernel/try'

tests Kernel do

  unit :try do
    example = Struct.new(:name).new("bob")
    example.try(:name).assert == "bob"
  end

  unit :try => "without argument" do
    example = Struct.new(:name).new("bob")
    example.try.name.assert == "bob"
  end

end

tests NilClass do

  unit :try do
    nil.try(:name).assert == nil
  end

  unit :try => "without argument" do
    nil.try.name.assert == nil
  end

end
