require 'zlib'
require 'stringio'

# A convenient wrapper for the zlib standard library that allows
# compression/decompression of strings with gzip.

module Zlib

  ##class Stream < StringIO
  ##  def close; rewind; end
  ##end

  # Decompresses a gzipped string.
  def self.decompress(source)
    GzipReader.new(StringIO.new(source)).read
  end

  # Compresses a string using gzip.
  def self.compress(source)
    output = StringIO.new
    class << output
      def close; rewind; end
    end
    gz = GzipWriter.new(output)
    gz.write(source)
    gz.close
    output.string
  end

  # Zlib.inflate and Zlib.deflate are Ruby's own. Facets used to define
  # copies of them here.

end

