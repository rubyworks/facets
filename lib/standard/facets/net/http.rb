require 'net/http'

module Net

  # Returns a response object for the given URL or raises
  # an exception with the appropriate error status code if unable to
  # complete the request
  #
  #   Net.download('http://example.com/')
  #   Net.download('http://example.com/', 2) # fail after 2 redirects
  #
  # CREDIT: Daniel Huckstep
  def self.download(url, limit = nil)
    limit ||= 10
    raise ArgumentError, 'HTTP redirect too deep' if limit.zero?
    resp = Net::HTTP.get_response(URI.parse(url))
    case resp
    when Net::HTTPSuccess     then resp
    when Net::HTTPRedirection then download(resp['location'], limit - 1)
    else resp.error!
    end
  end

  # Downloads a given URL and saves it to disk at the specified path.
  # If path is not provided or nil, then the last segment in the path of
  # the URL is used as the file name.
  #
  # Takes a third parameters as a hash of options:
  # * <tt>limit</tt> - passed to Net.download to limit number of redirects
  # * <tt>mode</tt>, <tt>:open_args<tt>, etc - passed to File.write to save the file.
  #   For details on those options, see File.write
  #
  #   # Saves robots.txt to PWD as robots.txt
  #   Net.download_and_save('http://example.com/robots.txt')
  #
  #   # Saves robots.txt to PWD as example.txt
  #   Net.download_and_save('http://example.com/robots.txt', 'example.txt')
  #
  #   # Saves robots.txt to PWD as robots.txt, and writes the result as binary
  #   Net.download_and_save('http://example.com/robots.txt', nil, mode: 'wb')
  #
  # CREDIT: Daniel Huckstep
  def self.download_and_save(url, path = nil, options = {})
    opts = options.dup
    path = File.expand_path(path || url.split('/').last)
    raise ArgumentError.new('Save path is a directory') if File.directory?(path)
    resp = download(url, opts.delete(:limit))
    File.write(path, resp.body, opts) if resp.is_a?(Net::HTTPSuccess)
  end
end

