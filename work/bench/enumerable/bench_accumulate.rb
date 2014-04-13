# vim: sw=2 ts=2 ft=ruby expandtab tw=0 nu syn=on:
# file: accumulator.rb

require 'facets'
module Enumerable
  alias_method :facets_acc, :accumulate
end
require 'benchmark'
$:.unshift File.join( %w{ /home robert SW facets-2.4.1 lib } )
require 'facets/enumerable/accumulate1'
module Enumerable
  alias_method :robert_acc, :accumulate
end


x = [*1..1000].facets_acc
y = [*1..1000].robert_acc
N = 1_000

Benchmark::bmbm do |bm|
  bm.report("facets: accumulate") do 
    N.times do
      x + 1
    end
  end
  bm.report("robert: accumulate") do 
    N.times do
      y + 1
    end
  end
end
Rehearsal ------------------------------------------------------
facets: accumulate   3.020000   0.000000   3.020000 (  3.264273)
robert: accumulate   2.030000   0.000000   2.030000 (  2.062103)
--------------------------------------------- total: 5.050000sec

                         user     system      total        real
facets: accumulate   3.060000   0.010000   3.070000 (  3.121236)
robert: accumulate   2.030000   0.000000   2.030000 (  2.070343)
