
require 'benchmark'

# member?

$n = 50000

def range_nan
  $n.times { ('a'..'k').member?('f') }
  $n.times { ('a'..'k').member?('r') }
end

def range_small
  $n.times { (0..6).member?(3) }
  $n.times { (0..6).member?(7) }
end

def range_med
  $n.times { (0..1000).member?(500) }
  $n.times { (0..1000).member?(1001) }
end

# index

$a = [ 'x' ] * 100
$m = 500000

def range_index
  i = 1
  $m.times { $a[1..i]; i += 1 }
end

def length_index
  i = 1
  $m.times { $a[1,i]; i += 1 }
end

### --- bench ---

puts "\nINDEXING"
Benchmark.bm(15) do |b|
  b.report("range_index:") { range_index }
  b.report("length_index:") { length_index }
end

puts "\n\nNew vs. Old\n"

puts "\nCURRENT"
Benchmark.bm(15) do |b|
  b.report("range_nan:") { range_nan }
  b.report("range_samll:") { range_small }
  b.report("range_med:") { range_med }
end

puts "\nNEW"
require 'trix-dev/range/range'
Benchmark.bm(15) do |b|
  b.report("range_nan:") { range_nan }
  b.report("range_samll:") { range_small }
  b.report("range_med:") { range_med }
end

puts

