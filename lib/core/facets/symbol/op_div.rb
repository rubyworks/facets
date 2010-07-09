require 'facets/string/op_div'

class Symbol

  # Join with _path_ as a file path.
  #
  # * path - The path component(s) to append. [#to_s]
  #
  # Returns String of the receiver (as a path string), concatenated
  # with _path_.
  #
  #   (:merb / "string")   #=> "merb/string"
  #   (:merb / :symbol)    #=> "merb/symbol"
  #
  def /(path)
    File.join(to_s, path.to_s)
  end

end

