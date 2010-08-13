covers 'facets/stackable'

tests Stackable do

  c = Class.new do
    include Stackable
    def initialize
      @a = []
    end
  end

  unit :push do
  end

  unit :peek do
  end

  unit :poke do
  end

  unit :pop do
  end

  unit :pull do
  end

  unit :shift do
  end

  unit :unshift do
  end

end


