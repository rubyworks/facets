# = Instantize
#
# Instantize converts module methods into instance methods
# such that the first parameter is passed self at the instance level.
# This promotes DRY programming when wishing to offer both an inheritable
# and a module callable procedure.
#
#   module MyModule
#     extend Instantize
#
#     def self.jumble( obj, arg )
#       obj + arg
#     end
#   end
#
#   class String
#     include MyModule
#   end
#
#   MyModule.jumble( "Try", "Me" )  #=> "TryMe"
#
#   "Try".jumble( "Me" )            #=> 'TryMe'
#
# == Notes
#
# This module used to be called PromoteSelf. Instantize is more descriptive, but 
# a better name is probably still out there.
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2005 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.


# = Instantize
#
# Instantize converts module methods into instance methods
# such that the first parameter is passed self at the instance level.
# This promotes DRY programming when wishing to offer both an inheritable
# and a module callable procedure.
#
#   module MyModule
#     extend Instantize
#
#     def self.jumble( obj, arg )
#       obj + arg
#     end
#   end
#
#   class String
#     include MyModule
#   end
#
#   MyModule.jumble( "Try", "Me" )  #=> "TryMe"
#
#   "Try".jumble( "Me" )            #=> 'TryMe'
#
# == Notes
#
# This module used to be called PromoteSelf. Instantize is more descriptive, but 
# a better name is probably still out there.
#
module Instantize

  def self.append_features(mod)
    mod.extend self
  end

  def singleton_method_added( meth )
    d = %{
      def #{meth}(*args)
        #{self.name}.#{meth}(self,*args)
      end
    }
    self.class_eval d
    super(meth)
  end

end

# Constant Alias
Instantise = Instantize

