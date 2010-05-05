Covers 'facets/kernel/val'

Case Kernel do

  Unit :val? => "of nil" do
    f = nil
    t = 1
    f.refute.val?
    t.assert.val?
  end

  Unit :val? => "of empty array" do
    f = []
    t = [1]
    f.refute.val?
    t.assert.val?
  end

  Unit :val? => "of empty string" do
    f = ''
    t = '1'
    f.refute.val?
    t.assert.val? 
  end

end
