module Enumerable

  # Combines #zip and #map in a single efficient operation.
  #
  #   h = {}
  #   [1,2,3].map_with [:x,:y,:z] do |n,k|
  #     h[k] = n
  #   end
  #   h  #=> {:x=>1, :y=>2, :z=>3}
  #
  # @return [Hash]
  #
  # @author Michael Kohl
  def map_with(*arrays, &block)
    enum_for(:zip, *arrays).map(&block)
  end

  #
  alias_method :zip_map, :map_with

end
