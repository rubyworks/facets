require 'net/http'

module Net

  # CREDIT: Daniel Huckstep
  def self.download(url, limit=10)
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0
    #url = URI.parse(url)
    #req = Net::HTTP::Get.new(url.path)
    #req['User-Agent'] = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.7) Gecko/2009030422 Ubuntu/8.10 (intrepid) Firefox/3.0.7"
    #resp = Net::HTTP.new(url.host, url.port).start { |http| http.request(req) }
    resp = Net::HTTP.get_response(URI.parse(url))
    case resp
    when Net::HTTPSuccess     then resp
    when Net::HTTPRedirection then download(resp['location'], limit - 1)
    else resp.error!
    end
  end

  # CREDIT: Daniel Huckstep
  def self.download_and_save(url, path=nil)
    if path.nil?
      path = File.expand_path(url.split('/').last)
    else
      path = File.expand_path(path)
    end
    raise ArgumentError.new('Save path is a directory') if File.directory?(path)
    resp = download(url)
    open(path,'w') { |file| file.write(resp.body) } if resp.is_a?(Net::HTTPSuccess)
  end
end

