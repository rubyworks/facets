module Enumerable
    def visit(&block)
puts "#=> Enumerable#visit: self=0x#{self.object_id}= #{self.inspect}"
      if block_given?
        result = map{ |e| e.visit(&block) }
      else
        result = to_enum(:visit)
      end
puts "#=> Enumerable#visit: result=0x#{result.object_id}= #{result.inspect}"
      result
    end
  end

  class Object
    def visit(&block) ; block.call(self) ; end
  end

arr = [ 10, [ 210 ], 30 ]
it = arr.visit
#=> Enumerable#visit: self=0x13928400= [10, [210], 30]
#=> Enumerable#visit: result=0x13927776= #<Enumerator:0x1a90ac0>

puts ; rr = it.each{ |x| x+7 }
#=> Enumerable#visit: self=0x13928400= [10, [210], 30]
#=> Enumerable#visit: self=0x13928416= [210]
#=> Enumerable#visit: result=0x1562576= [217]
#=> Enumerable#visit: result=0x13926848= [17, [217], 37]
puts "#=> rr=0x#{rr.object_id}= #{rr.inspect}"
#=> rr=0x13926848= [17, [217], 37]

puts ; rr = it.map{ |x| x+7 }
#=> Enumerable#visit: self=0x13928400= [10, [210], 30]
#=> Enumerable#visit: self=0x13928416= [210]
#=> Enumerable#visit: result=0x1559360= [nil]
#=> Enumerable#visit: result=0x1559840= [nil, [nil], nil]
puts "#=> rr=0x#{rr.object_id}= #{rr.inspect}"
#=> rr=0x1561088= [17, 217, 37]

# Note that the last Enumerable#visit result from it.map
# has the same structure as the original nested array
# (albeit with nil values - dunno why at the moment),
# but that the return value of it.map is a flat array
# of the successive results of the block calculation.

#Changing:
      if block_given?
        result = map{ |e| e.visit(&block) }
      end
#to:
      if block_given?
        result = each{ |e| e.visit(&block) }
      end
#gives for it.map:

puts ; rr = it.map{ |x| x+7 }
#=> Enumerable#visit: self=0x14484864= [10, [210], 30]
#=> Enumerable#visit: self=0x14484896= [210]
#=> Enumerable#visit: result=0x14484896= [210]
#=> Enumerable#visit: result=0x14484864= [10, [210], 30]
puts "#=> rr=0x#{rr.object_id}= #{rr.inspect}"
#=> rr=0x1298112= [17, 217, 37]

