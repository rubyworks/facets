class Symbol

  # Useful extension for &:symbol which makes it possible
  # to pass arguments for method in block
  #
  #   ['abc','','','def','ghi'].tap(&:delete.(''))
  #   #=> ['abc','def','ghi']
  #
  #   [1,2,3].map(&:to_s.(2))
  #   #=> ['1','10','11']
  #
  #   ['abc','cdef','xy','z','wwww'].select(&:size.() == 4)
  #   #=> ['cdef', 'wwww']
  #
  #   ['abc','aaA','AaA','z'].count(&:upcase.().succ == 'AAB')
  #   #=> 2
  #
  #   [%w{1 2 3 4 5},%w{6 7 8 9}].map(&:join.().length)
  #   #=> [5,4]
  #
  # CREDIT: Ilya Vorontsov, Nobuyoshi Nakada

  def call(*args, &block)
    proc do |recv|
      recv.__send__(self, *args, &block)
    end
  end

end
