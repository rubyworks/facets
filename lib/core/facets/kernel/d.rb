module Kernel

  # Like #p but gives file and line number...
  #
  #   d("hi")
  #
  # produces ...
  #
  #   "hi" (/home/dave/projects/foo.rb, 38)
  #
  def d(*x)
    puts "#{x.inspect} #{caller[0]}"
    return *x
  end
  
  #--
  # Old definition ...
  #
  #   def d(*x)
  #     puts "#{__FILE__}, #{__LINE__}"
  #     x.each{ |e| puts e.inspect } #p(*x)
  #     x.size > 1 ? x : x.last #x.last
  #   end
  #++

end

