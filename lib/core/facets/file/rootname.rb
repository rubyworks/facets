class File

  # Returns onlt the first portion of the directory of
  # a file path name.
  #
  #   File.rootname('lib/jump.rb')  #=> 'lib'
  #   File.rootname('/jump.rb')     #=> '/'
  #   File.rootname('jump.rb')      #=> '.'
  #
  #   CREDIT: Trans
  #
  def self.rootname(path)
    # this should be fairly robust
    path_re = Regexp.new('[' + Regexp.escape(File::Separator + %q{\/}) + ']')

    head, tail = path.split(path_re, 2)
    return '.' if path == head
    return '/' if head.empty?
    return head
  end

  #def self.rootname( file_name )
  #  i = file_name.index('/')
  #  if i
  #    r = file_name[0...i]
  #    r == '' ? '/' : r
  #  else
  #    '.'
  #  end
  #end

end

