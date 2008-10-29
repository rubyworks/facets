module Kernel

  def __HERE__
    "#{__FILE__}: #{__LINE__}"
  end

  # Like #p but gives file and line number.
  #
  #   d("hi")
  #
  # produces
  #
  #   /home/dave/projects/foo.rb, 38
  #   "hi"
  #
  # TODO: This is borderline "prime". Keep here?
  #       Another copy of it exits in dtools.rb

  def d(*x)
    puts "#{__FILE__}, #{__LINE__}"
    x.each{ |e| puts e.inspect } #p(*x)
    x.size > 1 ? x : x.last #x.last
  end

end

