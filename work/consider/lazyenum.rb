require 'enumerator'

module Enumerable
  def lmap(&blk)
    Enumerator.new do |y|
      each do |e|
        y << blk[e]
      end
    end
  end

  def lselect(&blk)
    Enumerator.new do |y|
      each do |e|
        y << e if blk[e]
      end
    end
  end

  def ltake(n)
    Enumerator.new do |y|
      count = 0
      each do |e|
        break if n <= count
        y << e
        count += 1
      end
    end
  end

  def lskip(n)
    Enumerator.new do |y|
      count = 0
      each do |e|
        y << e unless count <= n
        count += 1
      end
    end
  end
end

if __FILE__ == $0
  big = (1..1_000) #_000_000_000)
  big.lselect { |i| i % 2 == 1 }.lmap { |i| i + 100 }.
      lskip(5).ltake(10).each { |i| puts i }
end

