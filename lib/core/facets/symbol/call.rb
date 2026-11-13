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
  # CREDIT: Ilya Vorontsov, Nobuyoshi Nakada

  def call(*args, &block)
    proc do |recv|
      recv.__send__(self, *args, &block)
    end
  end

end
