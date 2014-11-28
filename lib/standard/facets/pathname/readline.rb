class Pathname
  # Reads the first line of the file
  #
  # Captures the best practice from this post at stack overflow:
  # https://stackoverflow.com/questions/1490138/reading-the-first-line-of-a-file-in-ruby
  #
  # Credit: Ryan Duryea
  def readline(*args)
    open { |f| f.readline(*args) }
  end
end


