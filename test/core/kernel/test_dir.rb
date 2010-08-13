covers 'facets/kernel/__dir__'

tests Kernel do

  unit :__DIR__ do
    __DIR__.assert == File.dirname(__FILE__)
  end

  unit :__DIR__ => "with arguments" do
    __DIR__('tmp').assert == File.join(File.dirname(__FILE__), 'tmp')
  end

end
