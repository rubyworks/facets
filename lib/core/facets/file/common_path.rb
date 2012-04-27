class File

  # Given an array of path strings, find the longest common prefix path.
  #
  # @author Aaron Gibralter
  def self.common_path(*paths)
    return paths.first if paths.length <= 1

    arr = paths.sort
    f = arr.first.split('/')
    l = arr.last.split('/')
    i = 0
    i += 1 while f[i] == l[i] && i <= f.length
    f.slice(0, i).join('/')
  end

end
