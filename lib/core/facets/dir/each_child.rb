class Dir

  # Like #each, except the "." and ".." special files are ignored.
  #
  # CREDIT: Tyler Rick
  def each_child
    each do |file|
      yield file if file != "." and file != ".."
    end
  end

end

