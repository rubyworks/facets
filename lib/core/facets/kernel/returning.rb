module Kernel

  # A Ruby-ized realization of the K combinator.
  #
  #   returning Book.new do |book|
  #     book.title = "Imperium"
  #     book.author = "Ulick Varange"
  #   end
  #
  # Technically, #returning probably should force the return of
  # the stated object irregardless of any return statements that
  # might appear within it's block. This might differentiate
  # #returning from #with, however it also would require
  # implementation in Ruby itself.
  #
  #   CREDIT: Mikael Brockman

  def returning(obj=self) #:yield:
    yield obj
    obj
  end

end
