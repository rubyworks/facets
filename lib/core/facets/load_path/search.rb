class << $LOAD_PATH

  # Search load path for matching patterns.
  #
  def search(match)
    found = []
    uniq.map do |path|
      list = Dir.glob(File.join(File.expand_path(path), match))
      list = list.map{ |d| d.chomp('/') }
      found.concat(list)
    end
    found
  end

end

