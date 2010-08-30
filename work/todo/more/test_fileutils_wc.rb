

# TODO FileUtils#wc test needs needs a Mock File.

=begin #no test yet

  require 'test/unit'

  class TC_FileUtils_WC < Test::Unit::TestCase

    def setup
      @workdir = Dir.getwd
      @thisdir = $TESTDIR

      @file = 'test_file.txt'
    end

    def test_method
      assert_respond_to( FileUtils, :wc )
    end

    def test_wc
      Dir.chdir @thisdir
      begin
        assert_nothing_raised{ FileUtils.wc(@file) }
        assert_nothing_raised{ FileUtils.wc(@file,'bytes') }
        assert_nothing_raised{ FileUtils.wc(@file,'chars') }
        assert_nothing_raised{ FileUtils.wc(@file,'words') }
        assert_nothing_raised{ FileUtils.wc(@file,'lines') }
        assert_raises(RuntimeError){ FileUtils.wc(@file,'bogus') }
      ensure
        Dir.chdir @workdir
      end
    end

    def test_wc_results
      Dir.chdir @thisdir
      begin
        assert_equal([166,166,25,25],FileUtils.wc(@file))
        assert_equal(166,FileUtils.wc(@file,'bytes'),"Wrong number of bytes")
        assert_equal(166,FileUtils.wc(@file,'chars'),"Wrong number of chars")
        assert_equal(25,FileUtils.wc(@file,'words'),"Wrong number of words")
        assert_equal(25,FileUtils.wc(@file,'lines'),"Wrong number of lines")
      ensure
        Dir.chdir @workdir
      end
    end

  end

=end


