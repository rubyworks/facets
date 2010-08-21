require 'set'

class Set
  def power_set
    if empty?
      Set[ self ]
    else
      any_value = [to_a.first]
      subsubs = (self - any_value).power_set
      subsubs + subsubs.map{ |subset| subset + any_value }
    end
  end
end

class Array
  def power_set
    if empty?
      [self]
    else
      subset  = dup
      value   = [ subset.pop ]
      subsubs = subset.power_set
      subsubs.concat( subsubs.map{ |subset| subset + value } )
    end
  end
end

