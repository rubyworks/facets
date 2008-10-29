
  require 'benchmark'

  class Ret
    def initialize(a,b,c,d,e)
      @a = a
      @b = b
      @c = c
      @d = d
      @e = e
    end
  end

  @preobj = Object.new
  def @preobj.assign(a,b,c,d,e)
    @a = a
    @b = b
    @c = c
    @d = d
    @e = e
  end
  
  def return_list
    return 1, 2, 3, 4, 5
  end

  def return_array
    return [1, 2, 3, 4, 5]
  end

  def return_hash
    return { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5 }
  end

  def return_object
    return Ret.new(1, 2, 3, 4, 5)
  end

  def return_preobj
    return @preobj.assign(1, 2, 3, 4, 5)
  end

  def return_globals
    $a = 1; $b = 2; $c = 3; $d = 4; $e = 5
  end

  n = 50000
  Benchmark.bm(7) do |x|
    x.report("global") { n.times do ; return_globals ; end }
    x.report("preobj") { n.times do ; return_preobj ; end }
    x.report("object") { n.times do ; return_object ; end }
    x.report("array:") { n.times do ; return_array ; end }
    x.report("hash:")  { n.times do ; return_hash ; end }
    x.report("list:")  { n.times do ; return_list ; end }
  end

