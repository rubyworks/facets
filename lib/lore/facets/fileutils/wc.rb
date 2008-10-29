require 'fileutils'

module FileUtils

  # With no arguments, returns a four element array consisting of the number
  # of bytes, characters, words and lines in _filename_, respectively.
  #
  # Valid options are <tt>bytes</tt>, <tt>characters</tt> (or just 'chars'),
  # <tt>words</tt> and <tt>lines</tt>.
  #
  #   # Return the number of words in 'myfile'
  #   FileUtils.wc("myfile",'words')
  #
  # CREDIT Daniel J. Berger

  def wc(filename,option='all')
    option.downcase!
    valid = %w/all bytes characters chars lines words/

    unless valid.include?(option)
        raise "Invalid option: '#{option}'"
    end

    n = 0
    if option == 'lines'
        IO.foreach(filename){ n += 1 }
        return n
    elsif option == 'bytes'
        File.open(filename){ |f|
          f.each_byte{ n += 1 }
        }
        return n
    elsif option == 'characters' || option == 'chars'
        File.open(filename){ |f|
          while f.getc
              n += 1
          end
        }
        return n
    elsif option == 'words'
        IO.foreach(filename){ |line|
          n += line.split.length
        }
        return n
    else
        bytes,chars,lines,words = 0,0,0,0
        IO.foreach(filename){ |line|
          lines += 1
          words += line.split.length
          chars += line.split('').length
        }
        File.open(filename){ |f|
          while f.getc
              bytes += 1
          end
        }
        return [bytes,chars,words,lines]
    end
  end

end


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


