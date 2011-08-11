covers 'facets/kernel/val'

test_case Kernel do

  method :val? do

    test "of nil" do
      f = nil
      t = 1
      f.refute.val?
      t.assert.val?
    end

    test "of empty array" do
      f = []
      t = [1]
      f.refute.val?
      t.assert.val?
    end

    test "of empty string" do
      f = ''
      t = '1'
      f.refute.val?
      t.assert.val? 
    end

  end

end
