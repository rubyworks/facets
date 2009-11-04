#class Module
#
#  alias_method :_extend, :extend
#
#  def extend(*mod, &blk)
#    _extend *mod unless mod.empty?
#    _extend Module.new(&blk) if blk
#  end
#
#end
