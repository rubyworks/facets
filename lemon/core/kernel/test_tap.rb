Covers 'facets/kernel/tap'

Case Kernel do

  Unit :tap do
    x = "foo"
    r = ("foobar".tap{ |x| x.gsub!(/bar/, '') })
    r.assert == x
  end

  Unit :tap => "check internal value" do
    x = [1,2,3]
    x.tap{ |a|
      a.assert == x
    }
  end

end
