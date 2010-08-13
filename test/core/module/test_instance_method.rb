covers 'facets/module/instance_method'

tests Module do

  unit :instance_method! do
    c = Class.new do
      def x; "x"; end
    end

    x1 = c.instance_method!(:x)
    x2 = c.instance_method!(:x)

    x1.object_id.assert == x2.object_id
  end

end
