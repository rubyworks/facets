module Kernel

  alias_method :_extend, :extend

  def extend(*mod, &blk)
    _extend(*mod) unless mod.empty?
    _extend Module.new(&blk) if blk
    self
  end

end
