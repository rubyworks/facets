module Kernel

  # Similar to __FILE__, __DIR__ provides the directory
  # path to the current executing script.
  #
  # CREDIT: Trans

  def __DIR__(*paths)
    c = caller.first
    return nil unless c.rindex(/:\d+(:in `.*')?$/)
    file = $` # File.dirname(c)
    return nil if /\A\((.*)\)/ =~ file # eval, etc.
    #File.expand_path(File.join(File.dirname(file), paths))
    File.join(File.dirname(file), paths)
  end

  #--
  # Old defintion ...
  #
  #  def __DIR__
  #    (/^(.+)?:\d+/ =~ caller[0]) ? File.dirname($1) : nil
  #  end
  #++

end

