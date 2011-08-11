covers 'facets/enumerable/uniq_by'

test_case Enumerable do

  method :uniq_by do

    test do
      e = [-5, -4, -3, -2, -1, 0]
      r = (-5..5).to_a.uniq_by{ |i| i*i }
      r.assert == e
    end

  end

  #method :uniq_by! do
  #  test do
  #    e = [-5, -4, -3, -2, -1, 0]
  #    r = (-5..5).to_a
  #    r.uniq_by!{ |i| i*i }
  #    r.assert == e 
  #  end
  #end

end

