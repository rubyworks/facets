# = Instantiable
#
# Initialize modules, almost as if they were classes.
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.


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



