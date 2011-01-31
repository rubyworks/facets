class Dir

  # Like #each, except the "." and ".." special files are ignored.
  # You can use +ignore+ to override '.' and '..' and ignore 
  # other entries via a exact match or regular expression.
  #
  # CREDIT: Tyler Rick
  def each_child(*ignore)
    ignore = ['.', '..'] if ignore.empty?
    each do |file|
      yield file unless ignore.any?{ |i| i === file }
    end
  end

end

