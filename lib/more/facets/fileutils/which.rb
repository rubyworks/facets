require 'fileutils'

module FileUtils

  if const_defined?(:Win32Exts)
    Win32Exts.concat %w{.exe .com .bat .cmd}
    Win32Exts.uniq!
  else
    Win32Exts = %w{.exe .com .bat .cmd}
  end

  module_function

  # Looks for the first occurrence of _program_ within _path_.
  #
  # On the MS Windows platform, it looks for executables ending with .exe,
  # .bat and .com, which you may optionally include in the program name.
  # Returns <tt>nil</tt> if not found.
  #
  # CREDIT: Daniel J. Berger, Michael Granger
  #
  #--
  # The which() method was adopted from Daniel J. Berger, via PTools
  # which in in turn was adopted fromt the FileWhich code posted by
  # Michael Granger on http://www.rubygarden.org.
  #++
  def which(prog, path=ENV['PATH'])
    path.split(File::PATH_SEPARATOR).each {|dir|
      # Windows checks against specific extensions
      if File::ALT_SEPARATOR
        ext = Win32Exts.find{|ext|
          if prog.include?('.') # Assume extension already included
            f = File.join(dir,prog)
          else
            f = File.join(dir,prog+ext)
          end
          File.executable?(f) && !File.directory?(f)
        }
        if ext
          # Use backslashes, not forward slashes
          if prog.include?('.') # Assume extension already included
            f = File.join( dir, prog ).gsub(/\//,'\\')
          else
            f = File.join( dir, prog + ext ).gsub(/\//,'\\')
          end
          return f
        end
      else
        f = File.join(dir,prog)
        # Avoid /usr/lib/ruby, for example
        if File.executable?(f) && !File.directory?(f)
          return File::join( dir, prog )
        end
      end
    }
    nil
  end

end

