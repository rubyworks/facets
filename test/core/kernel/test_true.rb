covers 'facets/kernel/true'

test_case Kernel do

  method :true? do

    test "nothing is true? but true itself" do
      true.assert.true?

      nil.refute.true?
      false.refute.true?
      1.refute.true?
      :a.refute.true?
    end

  end

  method :false? do

    test "nothing is false? but false itself" do
      false.assert.false?

      nil.refute.false?
      true.refute.false?
      1.refute.false?
      :a.refute.false?
    end

  end

end
