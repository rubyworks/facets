class File

  # Return the head of path from the rest of the path.
  #
  #   File.split_root('etc/xdg/gtk')  #=> ['etc', 'xdg/gtk']
  #
  def self.split_root(path)
    path_re = Regexp.new('[' + Regexp.escape(File::Separator + %q{\/}) + ']')
    path.split(path_re, 2)
  end

end

