class Proc

  # Build a hash out of a Proc.
  #
  #   l = lambda { |s|
  #     s.a = 1
  #     s.b = 2
  #     s.c = 3
  #   }
  #   l.to_h  #=> {:a=>1, :b=>2, :c=>3}
  #
  #   CREDIT: Trans

  def to_h
    h = {}
    f = Functor.new{ |op, arg| h[op.to_s.chomp('=').to_sym] = arg }
    call( f )
    h
  end

end

