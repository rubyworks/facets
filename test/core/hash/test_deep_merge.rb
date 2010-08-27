covers 'facets/hash/recursive_merge'

testcase Hash do

  unit :recursive_merge do
    h1 = { :a=>1, :c=>{:x=>10} }
    h2 = { :b=>2, :c=>{:y=>11} }

    h = h1.recursive_merge(h2)

    h.assert == {:a=>1, :b=>2, :c=>{:x=>10, :y=>11}}
  end

  unit :recursive_merge! do
    h1 = { :a=>1, :c=>{:x=>10} }
    h2 = { :b=>2, :c=>{:y=>11} }

    h1.recursive_merge!(h2)

    h1.assert == {:a=>1, :b=>2, :c=>{:x=>10, :y=>11}}
  end

end
