covers 'facets/struct/replace'

test_case Struct do
  method :replace do
    test do
      s = Struct.new(:name, :age)

      o = s.new('bob', 60)
      o.name.assert == 'bob'
      o.age.assert == 60

      o.replace(:name=>'tom', :age=>40)

      o.name.assert == 'tom'
      o.age.assert == 40
    end
  end
end
