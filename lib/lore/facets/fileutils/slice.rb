require 'fileutils'

module FileUtils

  # In block form, yields the first number of ((*lines*)) of file ((*filename*)).
  # In non-block form, it returns an array of the first number of ((*lines*)).
  #
  #   # Returns first 10 lines of 'myfile'
  #   FileUtils.head("myfile")
  #
  def head(filename,lines=10) #:yield:
    a = []
    IO.foreach(filename){|line|
        break if lines <= 0
        lines -= 1
        if block_given?
          yield line
        else
          a << line
        end
    }
    return a.empty? ? nil : a
  end

  # In block form, yields the last number of ((*lines*)) of file ((*filename*)).
  # In non-block form, it returns the lines as an array.
  #
  # Note that this method slurps the entire file, so I don't recommend it
  # for very large files.  If you want an advanced form of ((*tail*)), I
  # suggest using file-tail, by Florian Frank (available on the RAA).
  # And no tail -f.
  #
  #   # Returns last 3 lines of 'myfile'
  #   FileUtils.tail("myfile",3)
  #
  def tail(filename,lines=10) #:yield
    IO.readlines(filename).reverse[0..lines-1].reverse
  end

  # In block form, yields lines ((*from*))-((*to*)).  In non-block form,
  # returns an array of lines ((*from*))-((*to*)).
  #
  #   # Returns lines 8-12 of 'myfile'
  #   FileUtils.body("myfile",8,12)
  #
  # CREDIT Shashank Date, via Daniel Berger.

  def slice(filename,from,to) #:yield:
    IO.readlines(filename)[from-1..to-1]
  end

end


# TODO This test have been remarked out until such time
#      as a mock FileSystem can be used to test it against.

=begin #test

  require 'test/unit'

  # FIND TEST DIRECTORY
  paths = File.expand_path(File.dirname(__FILE__)).split('/')
  paths.size.downto(1) do |i|
    f = (paths.slice(0..i)+['test']).join('/')
    $TESTDIR = File.join(f,'FIXTURE') if File.directory?(f)
  end
  raise unless $TESTDIR

  class TC_FileUtils_HeadTail < Test::Unit::TestCase

    def setup
      @workdir = Dir.getwd
      @thisdir = $TESTDIR

      @tfile = 'test_file.txt'

      @expected_head1 = ["line1\n","line2\n","line3\n","line4\n","line5\n"]
      @expected_head1.push("line6\n","line7\n","line8\n","line9\n","line10\n")
      @expected_head2 = ["line1\n","line2\n","line3\n","line4\n","line5\n"]

      @expected_tail1 = ["line16\n","line17\n","line18\n","line19\n","line20\n"]
      @expected_tail1.push("line21\n","line22\n","line23\n","line24\n","line25\n")
      @expected_tail2 = ["line21\n","line22\n","line23\n","line24\n","line25\n"]

      @expected_body1 = ["line10\n", "line11\n", "line12\n", "line13\n", "line14\n"]
      @expected_body1.push("line15\n","line16\n", "line17\n", "line18\n", "line19\n","line20\n")
      @expected_body2 = ["line14\n","line15\n","line16\n","line17\n","line18\n","line19\n","line20\n"]
      @expected_body3 = ["line5\n","line6\n","line7\n","line8\n","line9\n","line10\n"]
    end

    def test_method
      assert_respond_to( FileUtils, :head )
      assert_respond_to( FileUtils, :tail )
      assert_respond_to( FileUtils, :slice )
    end

    # head

    def test_head
      Dir.chdir @thisdir
      begin
      assert_nothing_raised{ FileUtils.head(@tfile) }
      assert_nothing_raised{ FileUtils.head(@tfile,5) }
      assert_equal(@expected_head1,FileUtils.head(@tfile))
      assert_equal(@expected_head2,FileUtils.head(@tfile,5))
      ensure
        Dir.chdir @workdir
      end
    end

    # slice

    def test_slice
      Dir.chdir @thisdir
      begin
        assert_nothing_raised{ FileUtils.slice(@tfile,5,10) }
        assert_equal(@expected_body3,FileUtils.slice(@tfile,5,10))
      ensure
        Dir.chdir @workdir
      end
    end

    # tail

    def test_tail
      Dir.chdir @thisdir
      begin
        assert_nothing_raised{ FileUtils.tail(@tfile) }
        assert_nothing_raised{ FileUtils.tail(@tfile,5) }
        assert_equal(@expected_tail1,FileUtils.tail(@tfile))
        assert_equal(@expected_tail2,FileUtils.tail(@tfile,5))
      ensure
        Dir.chdir @workdir
      end
    end

  end

=end

