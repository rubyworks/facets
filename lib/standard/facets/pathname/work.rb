class Pathname

  # Work constant for building paths from root directory onward.
  #
  # Returns [Pathname]
  def self.work
    Pathname.new('.')
  end

end
