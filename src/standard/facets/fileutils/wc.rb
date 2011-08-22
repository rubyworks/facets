require 'fileutils'

module FileUtils

  module_function

  # With no arguments, returns a four element array consisting of the number
  # of bytes, characters, words and lines in _filename_, respectively.
  #
  # Valid options are +bytes+, +characters+ (or just 'chars'),
  # +words+ and +lines+:
  #
  #   # Return the number of words in 'myfile'
  #   FileUtils.wc("myfile",'words')
  #
  # CREDIT: Daniel J. Berger
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

