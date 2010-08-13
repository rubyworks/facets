covers 'facets/kernel/meta_eval'

tests Kernel do

  unit :meta_eval do
    c = Class.new
    c.meta_eval do
      def x; "x"; end
    end
    c.x.assert == "x"
  end

end
