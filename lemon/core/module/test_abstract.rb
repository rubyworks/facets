Covers 'facets/module/abstract'

Case Module do

  class Aq
    abstract :q
  end

  Unit :abstract do
    ac = Aq.new
    TypeError.assert.raised?{ ac.q }
  end

  Unit :abstract => "in an anonymous class" do
    ac = Class.new { abstract :q }.new
    TypeError.assert.raised?{ ac.q }
  end

end

