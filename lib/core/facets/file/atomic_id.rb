class File

  #
  def self.atomic_id
    (@atomic_id ||= 0) += 1
  end

end
