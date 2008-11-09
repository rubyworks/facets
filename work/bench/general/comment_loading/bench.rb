#
# Compare how long it takes to load commented
# vs. non-comment files.
#

require 'benchmark'

$n = 50000

def load_comments_none
  $n.times do
    load('comments_none.rb')
  end
end

def load_comments_sharp
  $n.times do
    load('comments_sharp.rb')
  end
end

def load_comments_begin
  $n.times do
    load('comments_begin.rb')
  end
end

def load_comments_end
  $n.times do
    load('comments_end.rb')
  end
end

### --- bench ---

puts "\nComment Loading"

Benchmark.bm(15) do |b|
  b.report("sharp :") { load_comments_sharp }
  b.report("begin :") { load_comments_begin }
  b.report("w/end :") { load_comments_end }
  b.report("none  :") { load_comments_none }
end



