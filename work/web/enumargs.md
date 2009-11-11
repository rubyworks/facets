      <div class="spy">
        <span class="spot">I Spy</span> EnumerablePass
      </div>

      <p>[NOTE: <i>This module used to be called EnumerableArgs.</i>]</p>

      <p>Has it ever occurred to you that you can't define an #each method which takes parameters
      and have it work with the Enumerable mixin? It's true. Try it and you'll get an ArgumentError.
      Enumerable's methods just weren't designed to pass through any parameters to #each.
      Well, if you've never thought about it before, I suppose it's never been a bother.
      But if you're one of the unlucky few who has actually tried to do so, probably not thinking much
      of it, you know just how frustrating it is. You are reduced to writing your own #find, #map, #select
      and the many other normally eager-to-mix methods of Enumerable.</p>

      <p>No Worries. EnumerablePass is here. Simply include it into your class and it will take
      care of the rest. It's quite nearly 100% compatible to Enumerable in every way. So you
      shouldn't miss a beat.</p>

      <p>Here's a simply example of how EnumberablePass can be useful.</p>

      <pre>
        class &lt;&lt; ObjectSpace
          include EnumerablePass
          alias :each, :each_object
        end
      </pre>

      <p>With the above it becomes possible to use all the familiar Enumerable methods
      when looking through Ruby's object space!</p>

