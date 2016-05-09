#
# Returns a randomly generated string. One possible use is
# password initialization. Takes a max legnth of characters
# (default 8) and an optional valid char Regexp (default /\w\d/).
#
#--
#
# CREDIT goes to George Moschovitis.
#
# NOTE This is not very efficient. Better way?
#
#++

def String.random(max_length = 8, char_re = /[\w\d]/)
  # gmosx: this is a nice example of input parameter checking.
  # this is NOT a real time called method so we can add this
  # check. Congrats to the author.
  raise ArgumentError.new('char_re must be a regular expression!') unless char_re.is_a?(Regexp)

  string = ""

  while string.length < max_length
      ch = rand(255).chr
      string << ch if ch =~ char_re
  end

  return string
end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO
