class Pathname

  # Glob pathnames.
  def glob(match, *opts)
    flags = glob_flags(opts)
    Dir.glob(::File.join(self.to_s, match), flags).collect{ |m| self.class.new(m) }
  end

  # Return the first glob match.
  #
  # DEPRECATE: While slightly faster then glob().first, not really worth it
  # unless this can be rewritten to shortcut on first match (using fnmatch?).
  # In wich case, is there a better name for this method?
  def glob_first(match, *opts)
    flags = glob_flags(opts)
    file = ::Dir.glob(::File.join(self.to_s, match), flags).first
    file ? self.class.new(file) : nil
  end

  # Return globbed matches with pathnames relative to the current pathname.
  def glob_relative(match, *opts)
    flags = glob_flags(opts)
    files = Dir.glob(::File.join(self.to_s, match), flags)
    files = files.map{ |f| f.sub(self.to_s.chomp('/') + '/', '') }
    files.collect{ |m| self.class.new(m) }
  end

  # Does a directory contain a matching entry?
  # Or if the pathname is a file, same as #fnmatch.
  #
  # TODO: Move to own file? Better name?
  #
  # Returns [Pathname]

  def include?(pattern,*opts)
    if directory?
      glob_first(pattern,*opts)
    else
      fnmatch(pattern,*opts)
    end
  end

private

  def glob_flags(opts)
    flags = 0
    opts.each do |opt|
      case opt when Symbol, String
        flags += ::File.const_get("FNM_#{opt}".upcase)
      else
        flags += opt
      end
    end
    flags
  end

end
