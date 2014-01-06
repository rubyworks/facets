require 'benchmark'

# Each
Benchmark.bmbm do |x|
  n = 26 #1000000
  a = *0...1000000 #('a'..'z').to_a

  x.report("each") do
    n.times { a.each{ |e| e } }
  end

  x.report("enumerator each") do
    n.times { a.each.each{ |e| e } }
  end

  x.report("each_with_index") do
    n.times { a.each_with_index{ |e,i| e; i } }
  end

  x.report("each and manual index") do
    n.times { i=0; a.each{ |e| e; i+=1 } }
  end

  x.report("enumerator each.with_index") do
    n.times { a.each.with_index{ |e,i| e; i } }
  end

  x.report("enumerator each and manual index") do
    n.times { i=0; a.each.each{ |e| e; i+=1 } }
  end

end

puts

# Map
Benchmark.bmbm do |x|
  n = 26 #1000000
  a = *0...1000000 #('a'..'z').to_a

  x.report("map") do
    n.times { a.map{ |e| e } }
  end

  x.report("enumerator map") do
    n.times { a.each.map{ |e| e } }
  end

  x.report("map and manual index") do
    n.times { i=0; a.map{ |e| e; i+=1 } }
  end

  x.report("enumerator map.with_index") do
    n.times { a.map.with_index{ |e, i| e; i } }
  end

  x.report("enumerator map and manual index") do
    n.times { i=0; a.each.map{ |e| e; i+=1 } }
  end

end
