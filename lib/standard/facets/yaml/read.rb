module YAML

  # Alias for `YAML.load_file` and the same as:
  #
  #   YAML.load(File.new(file))
  #
  def self.read(file)
    load(File.new(file))
  end

end

