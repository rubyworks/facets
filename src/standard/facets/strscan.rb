require 'strscan'

class StringScanner

  # scans string until +pattern+ is encountered. If +pattern+ will not be
  # encountered then it returns _nil_ but if +scan_anyway+ is _true_ then
  # it scans until the end of the string.
  def scan_before(pattern, scan_anyway = false)
    if not check_until(pattern) and not scan_anyway then return nil; end
    result = ""
    result << getch until check(pattern) or eos?
    return result
  end

end

