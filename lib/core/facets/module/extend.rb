class Module

  alias_method :_extend, :extend

  def extend(mod=nil, &blk)
    _extend mod if mod
    _extend Module.new(&blk) if blk
  end

end

