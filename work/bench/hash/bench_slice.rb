require 'benchmark'

class Hash

  def slice1(*keep_keys)
      h = {}
      keep_keys.each do |key|
        h[key] = fetch(key)
      end
      h
    end

  def except1(*less_keys)
    slice1(*keys - less_keys)
  end 

  def slice2(*keys)
    Hash[select {|k,v| keys.include? k}]
  end

  def except2(*keys)
    reject {|k,v| keys.include? k}
  end

end

#

Benchmark.bmbm do |x|
  n = 10
  a = (0..1000).to_a
  h = (0..10000).inject({}){|h, e| h[e] = e ; h}

  # slice

  x.report("slice1") do
    n.times do
      h.slice1(*a)
    end
  end

  #x.report("slice2") do
  #  n.times do
  #    h.slice2(*a)
  #  end
  #end

  # except

  x.report("except1") do
    n.times do
      h.except1(*a)
    end
  end

  x.report("except2") do
    n.times do
      h.except2(*a)
    end
  end

end
