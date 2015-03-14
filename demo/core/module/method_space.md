## Module#method_space

    require 'facets/module/method_space'

    class A
      attr_writer :x
      method_space :inside do
        def x; @x; end
      end
    end

    a = A.new
    a.x = 10

We can see that the `inside` method space has access to the instance space.

    a.inside.x  #=> 10

But there is no reader in the instance space.

    expect NoMethodError do
      a.x
    end

