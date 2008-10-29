class File

  #
  def self.split_root(path)
    path_re = Regexp.new('[' + Regexp.escape(File::Separator + %q{\/}) + ']')
    path.split(path_re, 2)
  end

end

