covers 'facets/kernel/ergo'

tests Kernel do

  unit :ergo do
    "a".ergo.upcase.assert == "A"
    nil.ergo.foobar.assert == nil
  end
 
  unit :ergo do
    "a".ergo{ |o| o.upcase }.assert == "A"
    nil.ergo{ |o| o.foobar }.assert == nil
  end
end

tests NilClass do

  unit :ergo do
    "a".ergo{ |o| o.upcase }.assert == "A"
    nil.ergo{ |o| o.bar }.assert == nil
  end

end
