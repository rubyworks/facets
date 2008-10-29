=begin

Some speed comparisions between yield vs. block.

=end

require 'benchmark'

$n = 10000
$b = proc { 1 }

# standard array

def with_yield
  yield
end

def with_block( &yld )
  yld.call
end

def with_bracket( &yld )
  yld[]
end

# bench calls

def call_with_yield
  $n.times do
    with_yield { 1 } 
  end
end

def call_with_yield_on_proc
  $n.times do
    with_yield &$b
  end
end

def call_with_block
  $n.times do
    with_block { 1 }
  end
end

def call_with_block_on_proc
  $n.times do
    with_block &$b
  end
end

def call_with_bracket
  $n.times do
    with_bracket { 1 }
  end
end

def call_with_bracket_on_proc
  $n.times do
    with_bracket &$b
  end
end

### --- bench ---

puts "\nYield vs. Block"
Benchmark.bm(15) do |b|
  b.report("block           :") { call_with_block }
  b.report("block a proc    :") { call_with_block_on_proc }
  b.report("bracket         :") { call_with_bracket }
  b.report("bracket a proc  :") { call_with_bracket_on_proc }
  b.report("yield           :") { call_with_yield }
  b.report("yield a proc    :") { call_with_yield_on_proc }
end

