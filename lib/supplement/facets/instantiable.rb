# = Instantiable
#
# Initialize modules, almost as if they were classes.
#
# Alows a module to be used much like a class, by defining
# a #new method that creates a class on demand.
#
module Instantiable

  def self.append_features(mod)
    mod.extend self
  end

  # Never use a class agian! ;)

  def new(*args,&blk)
    mod = self
    @instantiable_class ||= Class.new{include mod}
    @instantiable_class.new(*args,&blk)
  end

end



