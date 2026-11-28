class Numeric

  # The units used by #strfbytes, each 1024 times the one before.
  BYTE_UNITS = %w{KB MB GB TB PB EB ZB YB}.freeze

  # Format a number of bytes in the largest unit that fits, as a size is
  # usually shown for a file or for memory.
  #
  #   512.strfbytes            #=> "512 bytes"
  #   1024.strfbytes           #=> "1.00 KB"
  #   1048576.strfbytes        #=> "1.00 MB"
  #   3000000.strfbytes        #=> "2.86 MB"
  #   1073741824.strfbytes     #=> "1.00 GB"
  #
  # A format string, as for `Kernel#format`, sets how the number is shown.
  #
  #   1536.strfbytes('%.0f')   #=> "2 KB"
  #   1536.strfbytes('%.1f')   #=> "1.5 KB"
  #
  # The units are powers of 1024, so "KB" here is 1024 bytes, as it is in
  # most file listings. With facets/multipliers, `4.mebi.strfbytes` is
  # "4.00 MB".
  #
  # Returns a String.
  def strfbytes(fmt='%.2f')
    size = abs
    return "#{self} #{size == 1 ? 'byte' : 'bytes'}" if size < 1024

    value = to_f
    unit  = nil
    text  = nil

    BYTE_UNITS.each do |name|
      value /= 1024
      unit   = name
      text   = fmt % value
      # go on to the next unit if this one's number is, or rounds to, 1024
      break if value.abs < 1024 && text.to_f.abs < 1024
    end

    "#{text} #{unit}"
  end

end
