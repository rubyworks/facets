require 'ostruct'

class OpenStruct

  #
  def to_h
    @table.dup
  end

end
