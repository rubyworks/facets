# Extension mixin

module Extension

  def self.included(base)
    name = base.name.split('::').last
    core = eval("::#{name}")
    core.send(:include, base)
  end

end


if __FILE__ == $0

  module Facets
    module String
      include Extension

      def drippy
        puts "Drippy #{self}"
      end
    end
  end

  "Hello".drippy

end


