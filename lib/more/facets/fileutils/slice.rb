require 'fileutils'

module FileUtils

  module_function

  # In block form, yields lines +from+-+to+.  In non-block form, returns
  # an array of lines +from+-+to+:
  #
  #   # Returns lines 8-12 of 'myfile'
  #   FileUtils.body("myfile",8,12)
  #
  # CREDIT Shashank Date, via Daniel Berger.

  def slice(filename,from,to) #:yield:
    IO.readlines(filename)[from-1..to-1]
  end

  # In block form, yields the first number of +lines+ of file +filename+.
  # In non-block form, it returns an array of the first number of +lines+:
  #
  #   # Returns first 10 lines of 'myfile'
  #   FileUtils.head("myfile", 10)
  #
  def head(filename,lines) #:yield:
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

  # In block form, yields the last number of +lines+ of file +filename+.
  # In non-block form, it returns the lines as an array.
  #
  # Note that this method slurps the entire file, so I don't recommend it
  # for very large files. If you want an advanced form of +tail+, I
  # suggest using file-tail, by Florian Frank (available on the RAA):
  #
  #   # Returns last 3 lines of 'myfile'
  #   FileUtils.tail("myfile",3)
  #
  # And no tail -f.
  def tail(filename,lines) #:yield
    IO.readlines(filename).reverse[0..lines-1].reverse
  end

end

