require 'facets/file/rootname'

class Pathname

  #
  def rootname
    self.class.new(File.rootname(to_s))
  end

end
