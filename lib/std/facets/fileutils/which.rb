require 'fileutils'

module FileUtils

  if defined?(Win32Exts)
    Win32Exts |= %w{.exe .com .bat .cmd}
  else
    Win32Exts = %w{.exe .com .bat .cmd}
  end

  # Looks for the first occurrence of _program_ within _path_.
  #
  # On the MS Windows platform, it looks for executables ending with .exe,
  # .bat and .com, which you may optionally include in the program name.
  # Returns <tt>nil</tt> if not found.
  #
  # CREDIT Daniel J. Berger & Michael Granger
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


# TODO FileUtils#which This test needs a mock File.

=begin #no test yet

  require 'test/unit'
  require 'rbconfig'

  class TC_FileUtils_Which < Test::Unit::TestCase
    include Config

    def setup
      @workdir = Dir.getwd
      @thisdir = $TESTDIR

      @expected_ruby_exe = File.join( CONFIG['bindir'], CONFIG['ruby_install_name'] )
      if File::ALT_SEPARATOR
          @expected_ruby_exe.gsub!(/\//,'\\')
          @expected_ruby_exe += ".exe"
      end
    end

    def test_method
      assert_respond_to( FileUtils, :which )
    end

    # which

    def test_which
      Dir.chdir @thisdir
      begin
        ruby_exe = nil
        assert_nothing_raised { ruby_exe = FileUtils.which(CONFIG['ruby_install_name']) }
        assert_equal(@expected_ruby_exe, ruby_exe)
        assert_equal(nil, FileUtils.which("blahblah"))
      ensure
        Dir.chdir @workdir
      end
    end

  end

=end

