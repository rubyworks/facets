
class String

  # Escape special characters used in most
  # unix shells to use it, eg. with system().

  def shell_escape
    self.gsub(/([\\\t\| &`<>)('"])/) { |s| '\\' << s }
  end

end
