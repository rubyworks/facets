require 'net/http'

module Net

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

  # CREDIT: Daniel Huckstep
  def self.download_and_save(url, path = nil, options = {})
    path = File.expand_path(path || url.split('/').last)
    raise ArgumentError.new('Save path is a directory') if File.directory?(path)
    resp = download(url, options.delete(:limit))
    File.write(path, resp.body, options)
  end
end

