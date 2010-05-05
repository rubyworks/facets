Covers 'facets/module/alias_accessor'

Case Module do

  Unit :alias_accessor do
    x = Class.new do
      attr_accessor :x
      alias_accessor :y, :x
    end

    ix = X.new

    ix.x = 10
    ix.x.assert == 10
    ix.y.assert == 10

    ix.y = 20
    ix.x.assert == 20
    ix.y.assert == 20
  end

end

