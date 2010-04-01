class Symbol

  # Join with _path_ as a file path.
  #
  #   :merb / "core_ext"           #=> "merb/core_ext"
  #   :merb / :core_ext / :string  #=> "merb/core_ext/string"
  #
  # @param [#to_s] path The path component(s) to append.
  #
  # @return [String] The receiver (as path string), concatenated with _path_.
  #
  # @api public

  def /(path)
    File.join(to_s, path.to_s)
  end

end

