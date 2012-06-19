require "benchmark"
require "test/unit"

module Enumerable
  NEW_METHODS	= []

  def self.method_added(method_name)
    NEW_METHODS << method_name
  end

  def partition_by(&block)				# As defined by Facets.
    res	= Hash.new{|h, k| h[k]=[]}
    each{|e| res[yield(e)] << e}
    res
  end

  def partition_by_fast(&block)
    h = k = e = nil
    res	= Hash.new
    each{|e| (res[yield(e)] ||= []) << e}
    res
  end

  def cluster_by(&block)				# As defined by Facets.
    h	= {}
    each{|e| (h[block[e]] ||= []) << e}
    h.keys.sort!.map{|k| h[k]}				# Sorted by key.
  end

  def cluster_by_fast(&block)
    #partition_by_fast(&block).values.sort		# Sorted by value.
    partition_by_fast(&block).sort.transpose.pop	# Sorted by key.
  end
end

class EnumerableTest < Test::Unit::TestCase
  ARR			= [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  ARR_PARTITIONED	= {0=>[0, 2, 4, 6, 8], 1=>[1, 3, 5, 7, 9]}
  ARR_CLUSTERED		= [[0, 2, 4, 6, 8], [1, 3, 5, 7, 9]]

  HSH			= {0=>0, 1=>1, 2=>2, 3=>3, 4=>4, 5=>5, 6=>6, 7=>7, 8=>8, 9=>9}
  HSH_PARTITIONED	= {0=>[[0, 0], [2, 2], [4, 4], [6, 6], [8, 8]], 1=>[[1, 1], [3, 3], [5, 5], [7, 7], [9, 9]]}
  HSH_CLUSTERED		= [[[0, 0], [2, 2], [4, 4], [6, 6], [8, 8]], [[1, 1], [3, 3], [5, 5], [7, 7], [9, 9]]]

  def test_partition_by
    assert_equal(ARR_PARTITIONED, ARR.partition_by{|e| e%2}.each{|k, v| v.sort!})
    assert_equal(HSH_PARTITIONED, HSH.partition_by{|k, v| v%2}.each{|k, v| v.sort!})
  end

  def test_partition_by_fast
    assert_equal(ARR_PARTITIONED, ARR.partition_by_fast{|e| e%2}.each{|k, v| v.sort!})
    assert_equal(HSH_PARTITIONED, HSH.partition_by_fast{|k, v| v%2}.each{|k, v| v.sort!})
  end

  def test_cluster_by
    assert_equal(ARR_CLUSTERED, ARR.cluster_by{|e| e%2}.each{|a| a.sort!})
    assert_equal(HSH_CLUSTERED, HSH.cluster_by{|k, v| v%2}.each{|a| a.sort!})
  end

  def test_cluster_by_fast
    assert_equal(ARR_CLUSTERED, ARR.cluster_by_fast{|e| e%2}.each{|a| a.sort!})
    assert_equal(HSH_CLUSTERED, HSH.cluster_by_fast{|k, v| v%2}.each{|a| a.sort!})
  end
end

big_array	= (0...100000).to_a
big_hash	= (0...100000).inject({}){|h, e| h[e] = e ; h}

Benchmark.bmbm do |bm|
  Enumerable::NEW_METHODS.each do |method_name|
    method	= Enumerable.instance_method(method_name)

    bm.report(method_name.to_s) do
      10.times do
        method.bind(big_array).call{|e| e%10}
        method.bind(big_hash).call{|k, v| v%10}
      end
    end
  end
end
