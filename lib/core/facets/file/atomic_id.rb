class File

  #
  def self.atomic_id
    @atomic_id ||= 0
    @atomic_id += 1
  end

end
