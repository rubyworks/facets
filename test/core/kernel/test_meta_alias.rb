covers 'facets/kernel/meta_alias'

tests Kernel do

  unit :meta_alias do
    c = Class.new do
      def self.y?; "y?" ; end
    end
    c.meta_alias "ynot?", "y?"
    c.ynot?.assert == "y?"
  end

end

