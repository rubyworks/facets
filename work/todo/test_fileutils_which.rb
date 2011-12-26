

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

