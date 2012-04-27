require 'facets/cgi/escape_html'

class CGI

  # Instance level method for {CGI::escape_html}.

  def esc(string, *modes)
    self.class.escape_html(string, *modes)
  end

end
