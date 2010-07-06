= Facets Development Notes

This is a record of some musings along the way in the creatiojn of
Facets. It is not in any way all that important. Its' simply here
to give some historical context to development and to provide and
cues for recollection.

== Testing Rails with Facets Loaded

Add this to Rails' Rakefile:

  task 'test:facets' do
    require 'activesupport'
    require 'facets'
    Rake::Task['test'].invoke
  end

Run 'rake test:facets'.

== On the Name "Ruby Facets"

A lot of mental anguish went into finding this good project name Ruby Facets. Of course, in the end only one name can take the honor. Other good names which were considered: Calibre, Florida and California, Warchest w/ Atomix, Downs & Ace, Trix & Atomx and even Pillbox & Pills (a _why suggestion). Then the names that almost won out and were used for a good while: Nano Methods and Mega Modules --great names but a little too "fad". Finally let's not forget even older "working" titles that were used along the way: Raspberry, ABC, Succ and the very original Tomslib.

== Features that May Return

[EXTACTED FROM README]

It is possible to eliminate the need for the 'facets/' prefix on requires if the Facets libpaths are added to the LOAD_PATH. But this isn't as straight-forward as it is for most libraries b/c of the layout of Facets library.

  require 'facets-topload'
  require 'basicobject'

Understand that on the off chance that another library has the same name as one of Facets' everything will still work fine. You will just not be able to use the prefixless shortcut to require it.

== Some convesion extemnsions that turned out to be bad.

  class Symbol

    # Same functionality as before, just a touch more efficient.
    #
    #--
    # CHANGE transami@gmail.com - removed #freeze from #id2name
    # BAD BAD. Somehow it breaks things. Very weired breaks too,
    # like making Time#parse alwsy output Time.now _after_ first use.
    #++

    def to_s
      @to_s || (@to_s = id2name)
    end

    # Symbol's really are just simplified strings.
    # Thus #to_str seems quite reasonable.
    # This uses the Kernal#String method.
    #--
    # Maybe just change to #to_s?
    # BTW: This would be lots faster, I bet, if implemented in core.
    #
    # NOTE This causes Struct.new to bomb!
    #++

    def to_str
      String( self )
    end

  end

== String#to_a extension is too dangerous

  class String

    # Essentially makes #to_a an alias for split,
    # with the exception that if no divider is given
    # then the array is split on charaters, and
    # NOT on the global input record divider ($/).
    #
    # WARNING There is a slight chance of
    # incompatability with other libraries which
    # depend on spliting with $/ (although doing
    # so is a very bad idea!).

    #def to_a(div=//,limit=0)
    #  split(div,limit)
    #end

  end

== Lazy Enumerator

Brian Candler provided his Filter class.

Originally he had suggested to the Ruby community the idea l-methods for Enumerable.
Eg. lmap, lselect, etc.

== On <i>instance_</i> Methods

Kernel extension prefixed by instance_ which provide
internal (eg private) access to the object.
Kernel extension using instance_ prefix which is beneficial
to separation of metaprogramming from general programming.
object_ methods, in contrast to the instance_ methods,
do not access internal state.


== On <i>object_</i> Methods

I was considering this core addition to Facets:

  module Kernel
    alias_method :object_dup, :dup
    alias_method :object_clone, :clone
  end

Already Facets has #object_class. The method goes along with #object_id
and serves to stay out of the programmers way. Of course, since 'class'
is a keyword in Ruby, it doesn't help as much. However, mwhen using
method_missing one can exclude all object_* methods from removal so
as to still have access to these important introspective methods. That's
what I have traditionally done. Essentially,

  private *instance_methods.select{ |m| m !~ /^(__|instance_|object__)/ }

With the advent of 1.9 and BasicObject, this is no longer as important,
but BasicObject leaves us in a bit of a lurch, b/c it removes nearly 
everything leaving us no recourse to these methods. I can think of two
good solutions: 1) Have some global "methods" that can handle objects
at a higher level of abstraction. These can be defined as lambdas and
called using#[], eg.

  $class[x]
  $id[x]
  $dup[x]

The other is to define a special method, perhaps #object, using fluent
notaiton, we could handle this in a more object-oritented fashion:

  x.object.class
  x.object.id
  x.object.dup

In anycase, whatever might come along to provide this functionality, it
is clear that "object_" methods will not be the solution, and for
that reason #object_dup and #object_clone will never be facets.

