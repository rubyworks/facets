require 'yaml'

module Kernel

  # The Kernel method #yaml is a shortcut to YAML::load.
  #
  #   data = yaml %{
  #     a: 1
  #     b: 2
  #   }  
  #   data #=> {"a"=>1, "b"=>2}
  #
  def yaml(*args,&blk)
    YAML.load(*args,&blk)
  end

  # As with #to_yaml but removes the header line (i.e. '---') to create
  # a "YAML fragment".
  #
  # @author Trans
  #
  def to_yamlfrag
    y = to_yaml
    y.sub!(/---\ */, '')
    y
  end

end

