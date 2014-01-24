# Unfortunately NilClass#to_path causes FileUtils to bomb when testing
# for symlinks. See issue #77. It would be better if Ruby could be changed
# so this would work. But until then we have no choice but to deprecate
# this method.

#class NilClass
#  # Provide platform dependent null path.
#  #
#  # @standard
#  #   require 'facets/pathname'
#  #
#  # @author Daniel Burger
#  def to_path
#    Pathname.null
#  end
#end

class Array
  # Convert array to Pathname instance.
  #
  # @standard
  #   require 'facets/pathname'
  #
  def to_path
    Pathname.new(join('/'))
  end
end

