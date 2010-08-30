covers 'facets/hash/to_proc'

testcase Hash do

  unit :to_proc do
    c = Class.new do
      attr_accessor :a
    end

    h = {:a => 1}
    o = c.new

    h.to_proc.call(o)

    o.a.assert == 1
  end
  
end

