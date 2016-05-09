class String
  # Same as #shift.
  def pull
    return '' if size == 0
    self[0] = ''
    self
  end
end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
# TODO
