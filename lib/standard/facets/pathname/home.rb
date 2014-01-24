class Pathname

  # Home constant for building paths from root directory onward.
  #
  # TODO: Pathname#home needs to be more robust.
  #
  # Returns [Pathname]
  def self.home
    Pathname.new('~')
  end

end
