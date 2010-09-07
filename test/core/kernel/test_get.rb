covers 'facets/kernel/__get__'
covers 'facets/kernel/__set__'

tests Kernel do

  setup "an object with an instance variable" do
    c = Class.new do
      attr :a
      def initialize
        @a = 1
      end
    end
    c.new
  end

  unit :__get__ do |o|
    o.__get__('@a').assert == 1
  end

  unit :__set__ do |o|
    o.__set__('@a', 2)
    o.a.assert == 2
  end

  omit unit :__set__ => "support is being considered" do |o|
    o.__set__(:a, 3)
    o.a.assert == 3
  end

  omit unit :__get__ => "support is being considered" do |o|
    o.__get__(:a).assert == 1
  end

end
