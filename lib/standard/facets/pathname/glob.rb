require 'pathname'

class Pathname

  alias_method :_glob_original, :glob
  private :_glob_original

  # Extends Ruby's built-in Pathname#glob to accept symbol-based
  # flags in addition to the standard File::FNM_* constants.
  #
  #   Pathname.new('/tmp').glob('*', :dotmatch)
  #
  # Supported symbols: :noescape, :pathname, :dotmatch, :casefold
  #
  # Otherwise it is Ruby's own Pathname#glob. With a block, it gives the
  # block each match and returns nil.
  #
  def glob(match, *opts, &block)
    if opts.any? { |o| o.is_a?(Symbol) || o.is_a?(String) }
      _glob_original(match, glob_flags(opts), &block)
    else
      _glob_original(match, *opts, &block)
    end
  end

  # Return the first glob match.
  #
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
  # Returns [Pathname]
  def include?(pattern, *opts)
    if directory?
      glob_first(pattern, *opts)
    else
      fnmatch(pattern, *opts)
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
