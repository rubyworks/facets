covers 'facets/module/instance_function'

tests Module do

  setup "using instance_function" do
    Module.new do
      instance_function
      def self.jumble(obj, arg)
        obj + arg
      end
    end
  end

  unit :instance_function => "class method" do |m|
    r = m.jumble('Try', 'Me')
    r.assert == 'TryMe'
  end

  unit :instance_function => "instance method" do |m|
    s = 'Try'
    s.extend m
    r = s.jumble('Me')
    r.assert == 'TryMe'
  end

end
