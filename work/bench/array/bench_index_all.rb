class Array
  def index_all(&b)
    indexes = []
    each_with_index do |x, i|
      indexes << i if b.call(x)
    end
    indexes
  end
end

list = *1..10

def match?(x)
  x % 3 == 0
end

list.index_all{ |x| match?(x) }.each do |i|
  list[i], list[i+1] = list[i+1], list[i]
end

p list

list = *1..10

list.each_with_index do |x, i|
  if match?(x)
    list[i], list[i+1] = list[i+1], list[i]
  end
end

p list
