Covers 'facets/functor'

TestCase Functor do

  unit :to_proc do
    f = Functor.new do |op, *a|
      [op, *a]
    end
    p = f.to_proc
    p.assert.is_a? Proc
    p.call(:+,1,2,3).assert == [:+,1,2,3]
  end

end
