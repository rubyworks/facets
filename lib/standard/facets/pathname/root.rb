class Pathname

  # Root constant for building paths from root directory onward.
  #
  # Returns [Pathname]
  def self.root
    Pathname.new('/')
  end

end
