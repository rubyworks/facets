covers 'facets/hash/reverse_merge'

testcase Hash do

  unit :reverse_merge do
    h1 = { :a=>1, :b=>2, :c=>2 }
    h2 = { :c=>3 }
    h3 = h1.reverse_merge(h2)
    h3[:c].assert == 2
  end

  unit :reverse_merge! do
    h1 = { :a=>1, :b=>2, :c=>2 }
    h2 = { :c=>3 }
    h1.reverse_merge!(h2)
    h1[:c].assert == 2
  end

  unit :reverse_update do
    h1 = { :a=>1, :b=>2, :c=>2 }
    h2 = { :c=>3 }
    h1.reverse_update(h2)
    h1[:c].assert == 2
  end

end

