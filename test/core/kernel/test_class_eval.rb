covers 'facets/kernel/class_eval'

tests Kernel do

  unit :class_eval do
    c = Class.new
    c.class_eval do
      def x; "x"; end
    end
    c.x.assert == "x"
  end


end
