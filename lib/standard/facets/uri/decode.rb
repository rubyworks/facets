require 'uri'

module URI

  module_function

  # Decode the uri components.
  #
  def decode(uri)
    ## gmosx: hmm is this needed?
    ## guard against invalid filenames for example pictures with
    ## spaces uploaded by users
    escaped_uri = uri.gsub(/ /, "+")

    if md = URI::REGEXP::REL_URI.match(escaped_uri)
      path = "#{md[5]}#{md[6]}"
      type = File.extname(path)
      query_string = md[7]

      ## real_path = "#{$root_dir}/#{path}"

      parameters = URI.query_to_hash(query_string)
      path.gsub!(/\+/, " ")

      return [path, type, parameters, query_string]
    end

    ## this is usefull for uncovering bugs!
    raise ArgumentError.new("the parameter '#{uri}' is not a valid uri")
  end

end
