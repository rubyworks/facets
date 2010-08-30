covers 'facets/kernel/val'

testcase Kernel do

  unit :val? => "of nil" do
    f = nil
    t = 1
    f.refute.val?
    t.assert.val?
  end

  unit :val? => "of empty array" do
    f = []
    t = [1]
    f.refute.val?
    t.assert.val?
  end

  unit :val? => "of empty string" do
    f = ''
    t = '1'
    f.refute.val?
    t.assert.val? 
  end

end
