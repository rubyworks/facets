# Facets Release History

## 3.1.0 / 2016-05-10

More or less a minor release, but there are some backward incompatabilites
such as `Hash#except!` which no longer returns the rejected entries (use
`Hash#remove!` for old behavior).

Special thanks to Scott Parrish for all his help getting Facets in tip-top
shape.

Changes:

* New Features

  * Add `Hash#remove!` for old `except!` behavior.
  * Add `Array#standard_deviation`.
  * Add `Array#variance`.
  * Add `Array#average`.
  * Add `Numeric#delimit`.

* Improved Features

  * Change `Hash#except!` to not return rejected entries.
  * Improve definition of Character Set in `String.random`.
  * Add one to denominator of `String#similarity` score.
  * Enhanced download methods.
  * Improvements on compatability with ActiveSupport.
  * Enumerable#from and #thru return empty set when index is out of bounds.

* Bug Fixes

  * Fix `Enumerable#key_by`.
  * Fix `Enumerable#sum` to take initial value.


## 3.0.0 / 2014-11-11

This major release has been a long time in coming --too long in fact. As with
any "Point Oh" release, please expect a few hiccups and report them so we can
get a solid 3.1 release out as soon as possible.

This release is tailored for Ruby 2.0 and above. Ruby 1.9.x and older is no
longer supported. If you still need to use Facets with Ruby 1.9.x or older
then the excellent Backports project can be used to fill in the gaps. 

Changes:

* New Features

  * Add Array#arrange
  * Add Array#intersection
  * Add Array#missing
  * Add Array#uniqe_permutation
  * Add Dir.lookup method
  * Add Enumerator::Lazy#squeeze
  * Add Hash#fetch_nested
  * Add Hash#deep_rekey and Hash#deep_rekey!
  * Add Kernel#instance_extract
  * Add Math#EC for Euler's constant
  * Add Module#alias_class_method
  * Add Pathname#chdir
  * Add Pathname#readline
  * Add Proc.wrap (may become `Kernel#Proc()`)
  * Add Range#- and Range#+
  * Add Regexp#to_proc
  * Add String#each_match as alias for #mscan
  * Add Time.current

* Improved Features

  * Enumerable#sum argument is initial value.
  * Generalize Enumerable#sum to duck-type on `#+`.
  * Hash#collate can take multiple arguments.
  * Hash#collate no longer flattens automatically.
  * Time#past? and #future? use Time.current.
  * Better ActiveSupport compatibility.

* Renamed Features

  * Rename Object#replace to Object#instance_replace.
  * Rename Range#to_r to Range#to_rng, since #to_r is now for Rational.  
  * Rename Kernel#eigen to #meta.

* Bug Fixes

  * Fix Platform#inspect.

* Deprecated Features Now in Ruby

  * Deprecate Array#combination (now in Ruby).
  * Deprecate Array#index (now in Ruby).
  * Deprecate Array#permutation (now in Ruby).
  * Deprecate Array#product (now in Ruby).
  * Deprecate Array#rotate (now in Ruby).
  * Deprecate Array#rotate! (now in Ruby).
  * Deprecate Array#select! (now in Ruby).
  * Deprecate Binding#eval (now in Ruby).
  * Deprecate Float#round_at (now in Ruby as #round).
  * Deprecate Hash#select! (now in Ruby).
  * Deprecate Integer#even? (now in Ruby).
  * Deprecate Integer#odd? (now in Ruby).
  * Deprecate Kernel#__callee__ (now in Ruby).
  * Deprecate Kernel#__method__ (now in Ruby).
  * Deprecate Kernel#source_location (now in Ruby).
  * Deprecate NilClass#to_f (now in Ruby).
  * Deprecate NilClass#to_h (now in Ruby).
  * Deprecate Numeric#round_at (now in Ruby as #round).
  * Deprecate Proc#curry (now in Ruby).
  * Deprecate String#bytes (now in Ruby).
  * Deprecate String#each_char (now in Ruby).
  * Deprecate String#end_with (now in Ruby).
  * Deprecate String#lines (now in Ruby).
  * Deprecate String#start_with (now in Ruby).
  * Deprecate Symbol#to_proc (now in Ruby).
  * Deprecate UnboundMethod#name (now in Ruby).


## 2.9.3 / 2011-12-31

Happy New Year! Ruby Facets kicks off the year with a 2.9.x release.
This release adds a number of new methods, a few general improvements
and bug fixes, a couple of deprecations and finally settles the 
project down to a two-part core/standard project organization.

Changes:

* New Features

  * Add Hash#url_params. (Matt Kirk)
  * Add Enumerable#hashify. (Ronen Barzel)
  * Add String#briefcase, similar to #titlecase.
  * Add Kernel#hierarchical_send (better replacement for preinitialize.rb).
  * Add Class#hierarchically, which supports #hierarchical_send.
  * Add Array#median, to get the sorted middle of an array.
  * Add Math#percentile and Math#median.
  * Add Instantiable mixin (returns from Mixers spin-off project).
  * Add Equitable mixin (returns from Mixers spin-off project).
  * Add Cloneable mixin (returns from Mixers spin-off project).
  * Add Array#each_pair and #each_value.
  * Add Numeric#positive? and #numeric?.
  * Add Method#* and #^ composition methods. (Mike Burns)
  * Add back Fixnum::MAX and MIN constants.
  * Add Binding#with.

* Improved Features

  * Improve FileUtils#amass to be more robust.
  * Improve String#snakecase to convert spaces to underscores.
  * Improve String#camelcase to convert spaces to "camels".
  * Improve String#snakecase to not handle path names (use #pathize).
  * Improve String#camelcase to not handle module names (ise #modulize).
  * Improve Numeric#approx? bu using ratio.

* Renamed Features

  * Rename Enumerable#has? to #incase?.

* Bug Fixes

  * Fix Hash#rekey to keep default_proc.
  * Fix Binding#self to not be defined for Rubinius.

* Deprecations

  * Deprecate Preinitializable mixin.
  * Deprecate main.rb, spun-off to `main_like_module` gem.

* Implementation Details

  * Reconsolidated library into just two parts, `core` and `standard`.
  * The term "more" is just a synonym for "standard" now.
  * Relative requires are being used more extensively.
  * Collection scripts, e.g. `require 'facets'`, are static.


## 2.9.2 / 2011-08-23

The main purpose of this release is a fix for Module#redefine_method,
so it will not conflict with ActiveSupport. Beyond that a handful of new
methods have been added. This release also marks the start of using
a src/ directory to generate the lib/ directory.

Changes:

* New Features

  * Add Enumerable#map_with and alias #zip_map.
  * Hash#delete_values returns removed keys (#12).
  * Add clap-like command-line parser to Shellwords.
  * Add Module#let, akin to RSpec's method.
  * Add uncommon Module#method_clash method.
  * Add uncommon Class#singleton? method.

* Bug Fixes

  * Fix Module#redefine_method to use #remove_method.
  * Fix Kernel#object_hexid, or at least try to do so again.
  * Fix Exception#detail to not return backtrace if nil.


## 2.9.1 / 2011-01-30

Primarily this release fixes a couple of small issues. But also a handful of
new methods have been added.

Changes:

* New Features:

  * Add FileTest#absolute? and #relative?
  * Add FileTest#contains?
  * Add FileTest#safe?
  * Add FileUtils#amass
  * Add FileUtils#outofdate
  * Add FileUtils#stage
  * Add Kernel#yes? and Kernel#no?
  * Add Enumerable#has? (TOUR library)
  * Add Digest#salted_digest, etc.
  * Add Digest#base64digest (1.9.2 method)
  * Add String#random_binary

* Improved Features

  * Better OS detection in Platform class and RBConfig module
  * Moved CPU byte order methods from RBConfig to Platform class
  * General improvements to Platform class API

* Bug Fixes

  * Module#redefine_method need not check pre-existence of method
  * Fix string/unquote.rb recursive require
  * Kernel#object_hexid varies on CPU arch, not Ruby version.


## 2.9.0 / 2010-09-01

This release is fairly extensive as it was originally intended to be v3.0.
After further consideration it was decided to reserve v3.0 for the
polish of real world feedback and more progressive changes. The primary
focus of this release has been the completion of migrating Facets into a true
extensions library. With this release almost all add-on classes and mixins
have now been spun-off to other projects. Only the most general purposes
add-on classes and mixins remain.

A new TOUR library division has also been added to complement CORE and MORE.
This division houses purely optional extensions. The new division serves
a couple of useful purposes. In particular, it helps separates the standard
library extensions from optional core extension in the RDocs and thus makes
the perfect place to vet new extension ideas.

One important change that will effect anyone using Facets along side
ActiveSupport is that Facets no longer tries to conditionally avoid
method overlaps with ActiveSupport. This is fine for the upcoming
ActiveSupport 3.0 library which extends core classes directly instead of
using mixins. One need only require 'facets' in the Rails config/preinitializer.rb
file and ActiveSupport will take precedence over Facets. For older versions
of ActiveSupport, the best approach is to cherry pick from Facets just the
extensions you want, thus avoiding any conflicts. There are actually only a
dozen or so overlaps and all are intended to compatible, but it doesn't hurt
to be sure.

Lastly, it is worth mentioning that this release has been more thuroughly
tested than any version of Facets to date. Thanks to RVM this release runs
green on Ruby 1.8.6, 1.8.7 and 1.9.2.

Changes:

* New Features

  * Add Kernel#temporarily, set variables temporarily and eval block
  * Add Kernel#deep_clone, a better alternative to #deep_copy
  * Add Kernel#present? and Kernel#presence
  * Add Kernel#not and #not?
  * Add Array#extract_options!, for pulling options off argument list
  * Add Regexp#|, operator for Regexp#union
  * Add Array#percentile and Array#median
  * Add Module#memo, for instance level memoization
  * Add YAML.read method
  * Add Pathname#include?
  * Add Module#anonymous?
  * Add Module#copy_inheritor
  * Add Indexable#from and Indexable#upto
  * Add Array#from and Array#thru
  * Add NA class via na.rb
  * Add Memoizable in memoizable.rb for a more robust memoization system
  * Add Module#safe_memo in thread.rb for thread safe memoization
  * Add Kernel#sandbox in thread.rb for threaded $SAFE=4 evaluation
  * Add Hash#subset
  * Add Kernel#Y to tour library
  * Add numerous Math extensions

* Deprecations

  * Deprecate Module#attr_toggler as a YAGNI
  * Deprecate Kernel#class_eval b/c of it's confusing behavior
  * Deprecate Module#once is no longer an alias for #memoize
  * Deprecate Integer#succ(n) (for compatibility reasons)
  * Deprecate Stackable, it's method were moved to CORE
  * Deprecate Kernel#populate and #set_from (use #assign and #assign_from)
  * Deprecate Kernel#non_nil? since #not_nil? is enough
  * Deprecate #__HERE__ b/c implementation was unreliable
  * Deprecate Time#since, use #less instead
  * Deprecate Time#advance, use #shift instead
  * Deprecate Kernel#super_as (no good way to get callers method name)
  * Deprecate Integer#clear_bit, use #bit_clear instead
  * Deprecate Kernel#resc, use String#to_re or #to_rx instead
  * Deprecate Module#modspace
  * Deprecate Kernel#__ and class X for Proc#partial, use NA instead
  * Deprecate autoreload.rb has been spun-off to a separate project
  * Deprecate Module#nesting, b/c redundant and overlap with Module.nesting

* Renamed Features

  * Rename Module#parent            to Module#enclosure
  * Rename Module#parents           to Module#enclosures
  * Rename Module#parent_name       to Module#modname
  * Rename Array#recurisvely        to Array#recurse  
  * Rename Hash#recurisvely         to Hash#recurse
  * Rename Enumerable#recursive     to Enumerable#recursively
  * Rename Array#recursive          to Array#recursively
  * Rename Hash#recursive           to Hash#recursively        
  * Rename Kernel#silence_warnings  to Kernel#disable_warnings
  * Rename Hash#recursive_merge     to Hash#deep_merge
  * Rename Class#prepend            to Class#preallocate
  * Rename File#atomic_write        to FileUtils#atomic_write
  * Rename Module#conflict          to Module#method_clash
  * Rename Class#inheritor          to Module#class_inheritor
  * Rename Symbol#re_s              to Symbol#as_s
  * Rename String#chars             to String#characters
  * Rename String#outdent           to String#unindent
  * Rename Time#round               to Time#round_to
  * Rename Time#hence               to Time#shift (but keep aliases)
  * Rename Hash#zipnew              to Hash#zip

* Moved Libraries

  * Move roman.rb to integer/roman and string/roman.rb
  * Move blank.rb to kernel/blank.rb
  * Move facets-live.rb to facets/auto_core.rb
  * Move cattr.rb to MORE library
  * Move duplicable.rb to kernel/dup.rb
  * Move bitmask.rb to integer/bitmask.rb
  * Move enumerable/divide.rb to array/divide.rb
  * Move enumerable/split.rb to array/split.rb
  * Move enumerable/entropy.rb to array/entropy.rb
  * Move enumerable/probability.rb to array/probability.rb
  * Move enumerable/duplicates.rb array/duplicates.rb
  * Move module/enclosure.rb to optional TOUR libs
  * Move kernel/instance_exec to option TOUR libs

* Bug Fixes

  * Fix Fixed Hash#rekey! from clobbering previous keys
  * Fix Exception#raised? is a class method
  * Fix Enumerator#fx should use #map instead of #each
  * Fix String#splice needs String#store
  * Fix Kernel#blank? empty condition was faulty
  * Fix Comparable#bound needs clip.rb, not cap.rb
  * Fix String#file needs to pass block
  * Fix String#edit_distance use new encodings for Ruby 1.9

* Improved Features

  * New lib/tour division of libraries
  * Module#class_extend dynamically creates append_features method
  * Kernel#require_all is only for relative requires
  * __DIR__ can take subdirectory arguments
  * Hash#join has more sensible default separator (' ')
  * Some OpEsc escapes have been renamed
  * Kernel#assign does not accept a block
  * Kernel#try is now like ActiveSupport's
  * Improved #respond (which is like old #try)
  * Remove all `if defined?(ActiveSupport)` conditions
  * Use #random_range to support specialized Range#at_rand functionality
  * Use Comparable.[] instead of Comparable()
  * Array#rotate rotates in opposite direction than before (b/c or Ruby 1.9)


## 2.8.4 / 2010-04-27

A minor point release just to get a few improvements out there before
endeavering into more extensive work for the next major release.

* New Features

  * Added #glob_relative to Pathname

* Deprecations

  * Deprecated BlankSlate (use BasicObject)
  * Deprecate hashbuilder.rb
  * Removed casting_hash.rb, moved to new library
  * Removed opencollection.rb, moved to new library
  * Removed ansicode.rb, use ansi gem

* Bug Fixes

  * changed Numeric#length to return self, not to_s.self
  * Fix mispelling of Class#descendants

* Other Improvements

  * Range#at_rand has been optimized
  * Kernel#singleton_class no longer can take a block
  * Hash#to_proc takes response argument replacing #to_proc_with_response
  * OpenHash becomes more like OpenObject and OpenObject becomes bare bones
  * Range#at_rand optimized for Fixnum/Bignum instead of Integer


## 2.8.3 / 2010-04-10

New release which makes a few adjustments in Kernel core extensions,
adds a few new extensions and additions, plus other small improvements.
The biggest change is the addition of Recusor, which is created via
Enumerable#recursive. This class is somewhat like Enumerator and
provides a number of recursive methods.

Changes:

* 9 New Core Extensions

  * Enumerable#recursive provides a number of other recursive methods.
  * Enumerable#visit can be used to recursively iterate any Enumerable.
  * Module#set has been added (from Sinatra).
  * Symbol#/ is added to be like String#/.
  * Struct#to_h is added and will ultimately replace Struct#attributes.
  * ObjectSpace#reflect routes method calls to Kernel context.
  * Hash#to_module converts a hash to mixin module (Jay Fields).
  * Kernel#dup! is same as #try_dup from extlib.
  * Add File#ext which is a useful variation of #extname (Lavir the Whiolet).

* 3 Core Extensions Renamed

  * Renamed #set_from to #assign_from (alias remains until Kernel#set is considerd).
  * Renamed #populate to #assign and improve.
  * Kernel#instance_vars is now Kernel#instance and also more useful.

* 1 Core Deprecation

  * Removed #instance_eval hack.

* 2 Core Bug Fixes

  * #map_with_index now uses #each_with_index.
  * #to_proc_with_response spelling correction.

* 1 Core Adjustment

  * Aliased #metadef to #meta_def.

* 3 New More Libraries

  * casting_hash.rb provides CastingHash class, a hash with flexible keys and values.
  * prepend.rb allows for AOP-like inclusion of modules.
  * roman.rb provides simple roman numeral extensions to String and Integer.

* 5 More Improvements

  * Pathname#visit for iterating all entries beneath a path (chikamichi).
  * Pathname#to_str, b/c Pathname is basically a type of String (from extlib).
  * Range#at_rand in random.rb handles Float ranges (Lavir the Whiolet).
  * FileUtils#cp_rx provides controlled copies.
  * Stash class in stash.rb is improved and is now available as a stand-alone library.
  * ioredirect.rb has been removed as IORedirect no longer worked.
  * plugin_manager.rb has been removed. Use 'plugin' gem instead.


## 2.8.2 / 2010-02-22

This release fixes a bug by removing Numeric#size. Turns out that was a
core method already. It includes an "auditing" of the core enumerable
method which has led to a few modifications most noteable amoung them
renaming #map_detect to #find_yield and #compact_map to #purge.

Changes:

* 7 New Core Extensions

  * Add Enumerable#each_with_object.
  * Add #collapse which is a shortcut for flatten.compact.
  * Add Numeric#spacing (Mr. Groff)
  * Add Array#uniq_by! to complement Enumerable#uniq_by.
  * Add String#exclude? as opposite of #include?
  * Add Enumerable#exclude? as opposite of #include?
  * Add Proc#bind_to 

* 2 Extensions Renamed

  * Rename Enumerable#compact_map to #purge.
  * Rename Enumerable#map_detect to #find_yield.

* 4 Deprecations

  * Deprecate #inject!/#injecting in favor of #filter.
  * Deprecate Array#** as alias of #product.
  * Remove Numeric#size, as it was already used by core.
  * Spun tracepoint.rb off as a seprate library.

* 3 Other Changes

  * Integer#multiple? handles zero as an argument.
  * facets.rb is now dynamically loaded instead of code generated.
  * General imporvements to date.rb.


## 2.8.1 / 2009-12-25

This release simply fixes a few minor issues.

Changes:

* 1 New Standard Extension

  * Added Pathname#glob_relative to pathanme.rb.

* 3 Adjustments

  * Loading string/tab.rb no longer loads margin.rb or expand_tab.rb.
  * Fixed FileList method delegations.
  * Numeric#length and #size return +self+, not +to_s.length+.


## 2.8.0 / 2009-11-05

Facets 2.8 effectively completes the MORE library clean-up which peaked
with the previous 2.7 release. Another eight libraries have been deprecated,
a few of them spun-off to a separate project. However, this verison also
reverts a few of the deprecations made in the last version. These libs 
will remain in Facets's MORE library for the forseeable future.

This version effectively concludes the MORE library clean-up. The next, and
last version before Facets 3.0, will focus on "auditing" the CORE library.

Changes:

* 6 Libraries "Undeprecated":

  * ini.rb
  * linkedlist.rb
  * matcher.rb
  * memoizer.rb
  * roman.rb
  * semaphore.rb

* 5 Libraries Deprecated:

  * fileable.rb    (too esoteric)
  * ioredirect.rb  (needs better implementation)
  * coroutine.rb   (because of Fiber)
  * capsule.rb     (may be spun-off)
  * recorder.rb    (may be spun-off)

* 3 Libraries Spun-Off and Deprecated:

  * ansicode.rb           ansi
  * progressbar.rb        ansi
  * logger.rb             ansi

* Additonal Enhancements:

  * Kernel#extend can now take a block
  * Fixed kernel#d so it is useable
  * Added Range#at_rand (thanks to Tyler Rick)
  * Added Enumerable#map_detect (thanks to Scott Taylor)
  * String#/ calls File.join
  * Added String#newlines and String#cleanlines
  * String#titlecase includes apostrophe in words
  * BasicObject/BlankSlate is more compliant with 1.9.1 design
  * Enumerable#count can take multiple items, treats as logical Or
  * Class#class_extend extends class level, not class_eval
  * Integer#succ(n) becomes Fixnum#succ(n), succ.rb
  * Complete rewrite of Inheritor
  * Shellwords extensions have been reworked
  * Added String#similarity
  * Added Levenshtein String#edit_distance method
  * And other minor improvements (some thanks to ccjr)


## 2.7.0 / 2009-08-01

Facets 2.7 is the biggest release of Facets since 2.4. Rather then trickle-release these
changes over the course of the 2.6.x series, I made the decision to let 2.7 have them
all at once. In so doing this release nearly completes the process of trimming down
the MORE library to its essentials. Over 40 high-level libraries have been spun-off
as separate gems and/or deprecated. No doubt this is a big change for Facets, and the
transition may be a bit bumpy over the short-term, but I am certain that in the long-run
everyone involved will be better served. To help, I have listed the effected libraries
and the alternate gems availble to take their place.

A few other changes have also been made in the release that may also effect your code.
In particular you should note that #class_extension has been renamed to #class_extend
(require 'facets/class_extend'). In addition we have added a few new core methods such
as Exception#raised? and Symbol#thrown?.

Changes:

* Spun-Off Projects

These libraries have been deprectated from Facets entirely, but are available
as separate gems (or soon will be).

    LIBRARY               GEM
    --------------------  ------------------------------
    overload.rb           overload
    binreadable.rb        binaryio
    downloader.rb         downloader
    xoxo.rb               xoxo
    bicrypt.rb            bicrypt
    typecast.rb           typecast
    association.rb        association
    syncarray.rb          sync
    synchash.rb           sync
    paramix.rb            paramix
    crypt.rb              crypt3
    lrucache.rb           lrucache
    net/smtp_tls.rb       smtp_tls
    advisable.rb          advisable
    buildable.rb          buildable
    memoizer.rb           memoizer
    harray.rb             sparray
    sparse_array.rb       sparray
    iteration.rb          iteration
    interval.rb           stick
    infinity.rb           stick
    pool.rb               pool
    linkedlist.rb         linkedlist
    semaphore.rb          semaphore
    pqueue.rb             pqueue
    censor.rb             language
    matcher.rb            language
    basex.rb              radix
    minitar.rb            archive-tar-minitar -or- folio

* Spun-Off But Still Available

These libraries have been spun-off into stand-alone gems, but remain
available via Facets too. Ultimately some of these will be removed
from Facets too (in particular the ansi libraries).

    LIBRARY               GEM
    --------------------  ------------------------------
    ansicode.rb           ansi
    progressbar.rb        ansi
    logger.rb             ansi
    tracepoint.rb         tracepoint
    dictionary.rb         dictionary
    recorder.rb           recorder
    ostructable.rb        ostructable -or- openhash
    openobject.rb         openhash
    opencollection.rb     openhash
    opencascade.rb        openhash
    openhash.rb           openhash
    openmodule.rb         openmodule
    fileable.rb           fileable
    enumerablepass.rb     enumargs

* Deprecations Without Current Replacement

The libraries have been deprecated but do not yet have replacements.
Seperate gems for these are planned though.

    bbcode.rb
    ini.rb
    settings.rb
    xmlhash.rb

* Deprecations Merged Into CORE

These libraries have been deprecated because their functionality was merged into
the CORE library and/or made available in some another way.

    1stclassmethod.rb   #method! and #instance_method! are now part of CORE.
    elementor.rb        #per has been added to CORE.
    elementwise.rb      #ewise has been added to CORE.
    consoleutils.rb     #ask is in CORE, for the rest see Ansi or Clio project.
    attr.rb             Added Module#attr_setter to CORE, and separated the rest in MORE.

* General Deprecations

These libraries have simply been deprecated because they were found lacking in
some significant fashion.

    nilstatus.rb        Poved rather useless, not to mention trivial.
    heap.rb             Heap was just an alias for PQueue anyway. Use 'pqueue' instead.
    dependency.rb       Other solutions exist that are much better (like Advisable).
    classmethods.rb     #class_extend solution is more robust.
    ziputils.rb         Have a look at Folio (gem install folio) for replacement.
    unheritable.rb      Implementation is trivial and usefulness questionable.
    instantise.rb       Replaced by instance_function.rb.

* Other Enhancements

  * Fixed Proc#curry to work with #define_method (Thanks to R.Potter)
  * Module#class_extension has been renamed to #class_extend (require 'facets/class_extend').
  * kernel#instance is no longer in core; now it is an extra monkey patch for #instance_eval.
  * Kernel#this has been removed. It is equivalent to 'method(__method__)'.
  * BlankSlate is now an alias for BasicObject, and will be deprecated in the future.
  * Kernel#method! and Module#instance_method! now use a global variable for their cache.
  * #object_state (old name was #state) has been added to core.


## 2.6.0 / 2009-07-03

Facets 2.6.0 removes htmlfilter.rb and cssfilter.rb due to licensing
incompatability. These scripts are now available as a separate package
called 'htmlfilter'. Also removed are a few MORE libs that were too
expiremental and/or not robust enough. Effectively this finishes up
the "spring cleaning" of the MORE lib mentioned a few releases back.

But it also marks a new start in trimming MORE down further. We have
decided to do this for three reasons 1) Some of the MORE libs would
be better served as separate projects. 2) Facets will become a tighter
library, primarily focused on extensions. And 3) all libraries involved
will become easier to maintain and thus more robust in the long run.

This release also fixes an important arity bug with the recently added
Module#extend method --one of the very few actual core overrides in Facets.

Changes:

* 7 Major Enhancements

  * Removed htmlfilter.rb due to licensing issues.
  * Also removed cssfilter.rb ('gem install htmlfilter' now)
  * Removed rwdelegator.rb, simply not a robust solution.
  * Removed buildable.rb, api is too confusing.
  * Removed meta.rb which was not very useful and too expiremental anyway.
  * Removed prototype.rb, which needs it's own project.

* 3 Minor Enhancements

  * Removed Kernel#__HERE__ as it simply cannot work.
    (Ruby 1.9.2 will offer #source_location for the same, btw)
  * Returned binding/opvars to core.
  * Added Integer#length as suggested by Victor H. Goff III.

* 1 Bug Fix

  * Fixed arity issue with Module#extend.


## 2.5.2 / 2009-04-07

Facets 2.5.2 is a simple maintentance release which fixed a few issues
in the new to_hash.rb library. This release also added String#lowercase
and String#uppercae.

Changes:

* 1 Major Enhancement

  * added string/uppercase and lowercase

* 1 Minor Enhancement

  * adjustments to to_hash.rb


## 2.5.1 / 2009-03-05

Facets 2.5.1 fixes a few bugs, makes some small but nice additions
and improves 1.9 compatibility.

The most important addition to make note of is Object#extend, which has
been overridden to allow a block parameter. This is one of only two or three
actual "monkey patches" in all of Facets. The block, when provided,
is used to create an annonymous module which then extends the reciever.
This is a "good practice" way to extend objects, rather than using class_eval
on the singleton class.

Special thanks to Erik Veenstra, Pit Capitan and especially Sandor Szücs
for their contributions to this release.

Changes:

* 7 Major Enhancements

  * added Hash#group_by_value (thanks to Erik Veenstra)
  * added String#file
  * added Hash#new_with (Pit Capitan)
  * added module/extend.rb, now can take a block.
  * added hook.rb
  * added to_h_auto
  * overhauled to_hash.rb, now has multiple methods

* 10 Bug Fixes

  * corrected ostruct.rb to test for frozen state on updates
  * fixed String#left_align
  * fixed conflict between test_name.rb and test_arguments.rb
  * fixed Enumreable#split when reciever is empty array
  * fixed coruption of reciever by Hash#collate (thanks to Tilo Sloboda)
  * fixed Array#to_h, h={} was not initialized
  * fixed test of Module#conflict according ruby19
  * fixed Hash#dearray_singluar_values
  * association.rb stores reference when using #new
  * changed Array#product to make it compatible to ruby 19, deleted block parameter

* 5 Minor Enhancements

  * split enumerable/collect into map_with_index and compact_map
  * improved Array#to_h for 1.9 using flatten(1)
  * Dictionary#replace can take regular Hash too
  * move test_to_hash.rb from more to core
  * Doc'd that UnboundMethod#name returns Symbol in 1.9, but String in 1.8


## 2.5.0 / 2008-11-23

Facets 2.5.0 is an important milestone in the development of Facets.

This release has been tested against Rails' ActiveSupport library.
As long as Facets is loaded after ActiveSupport, everything
should work fine. Of course, there's no counting for real world
trials, but all ActiveSupport testcases pass under this scenario.

Secondly, this release is the first of two (or three) down-scaling
releases intended to remove all the remaining "excess" from the
library. This is being done for a variety of reasons. Some scripts
are substantial enough to be one their own and have been spun-off
into separate largely compatible projects. In this release:

  If you were using...   Use this project instead...

    annotations.rb         Anise

    bytes.rb               RichUnits
    times.rb

    command.rb             Clio
    consoleutils.rb

A few others scripts have been deprecated, without an alternative
recourse, simply because they were too weak, such as  uploadutils.rb,
or highly experimental, such as chain.rb and eventhook.rb.

Although this release constitutes an over all slimming down of Facets,
two excellent new libraries have been added.

1) *ini.rb* by Jeena Paradies. While YAML is frequently used by
Rubyists for configuration files, a full-on serializer like YAML
is often overkill. INI files provide a lightweight solution
specifically geared for configuration.

2) *filter.rb* by Brian Candler offers lazy evaluation chains of
Enumerable methods. This is an elegant way to optimize contiguous
maps, selections, etc. --effective even on infinite enumerators.
(Note, the name of this library may be changed in the next release.)

While work remains to be done, I am happy to say, Facets is
finally beginning to approach the level of solidity I set out to
achieve just over a year ago. Thank the Maker!

Special thanks to Brian Candler, Jeena Paradies and Tyler Rick.

Changes:

* 9 Major Changes

  * added Brian Candler's Enumerator::Filter
  * added sparse_array.rb (was old harray.rb)
  * added Jeena Paradies' ini.rb
  * renamed CacheDelegator to Memoizer
  * renamed DictionaryMatcher to just Matcher
  * deprecated bytes.rb and times.rb (use RichUnits instead)
  * deprecated uploadutils.rb; ziputils.rb will be (use Folio)
  * deprecated annotations.rb (use Anise instead)
  * deprecated command.rb and consoleutils.rb (use Clio instead)

* 5 Minor Changes

  * deprecated chain.rb (very expiremental)
  * deprecated eventhook.rb (moved to ToadCode project)
  * deprecated tagiter.rb (moved to ToadCode project)
  * moved Hash#symolize_keys and #stringify_keys to core lib
    (still recommend #rekey instead though)
  * switched to git as of 2.4.5

* 4 Bug Fixes

  * memoize.rb, cache was at class-level, now at instance-level
  * binding/caller.rb, fixed require for callstack.rb
  * fixed missing require in string/tabto.rb
  * Fixed some bugs with Time#ago/Time#hence not changing years
    correctly when you changed months.
    (For example, Time.utc(2008, 1, 1).ago(12, :months) incorrectly
    returned 2009-01-01 instead of 2007-01-01.)
    Changed Time#ago/Time#hence to still work if passed negative number.


## 2.4.5 / 2008-10-02

Facets 2.4.5 is a maintaince release. This release is notable however in that
it will likely be the last that to use SVN. Facets will be switching to Git.
Also, some libraries that have been flagged "to be deprecated" for some time
will finally be so.

Changes:

* 8 Major Enhancements

  * Re-added date.rb to lore library, and removed from core.  (#r1014)
  * Much improved date.rb extension now in Lore library.  (#r1027)
  * Deprecated kernel/suppress. Use Exception.suppress from now on.  (#r1040)
  * Deprecated string/style.rb. Use English project instead.  (#r1074)
  * Console namespace is no longer supported (for Ansicode).  (#r1077)
  * enumerable/mode.rb, Enumerable#mode returns array since there can be more than one.  (#r1079)
  * OpenCascade automatically creates nodes, use foo? to query.  (#r1056)
  * Change #index_of to #index which now takes a block.

* 14 Minor Enhancements

  * OpenStruct.new can now take a default block, like Hash.new.
  * Moved variablize methods out of metaid.rb and into separate files (string/ and symbol/).  (#r1042)
  * Added Time#advance.  (#r1046)
  * Speed up of Integer odd/even methods.  (#r1057)
  * Array#index now takes a block (this is a core override).  (#r1059)
  * Spilt file/write.rb into separate method files (append, create, writelines).  (#r1073)
  * Modified Enumerable#split to behave like String#split.  (#r1076)
  * hash/op.rb, split into separate method files.  (#r1081)
  * Added string/modulize. string/methodize handles path names now too.  (#r1085)
  * Class#cattr is now part of core.  (#r1089)
  * Modified Enumerable#split to behave like String#split.  [minor]
  * Removed Rope class. If anything this will have a separate project.
  * Added doc/news.html and doc/authors.html to website (temporarily?).
  * Added zlib.rb to Lore library.

* 7 Bug Fixes

  * OpenStruct#to_h dups internal table.  (#r1015)
  * Fixed require of string/xor in bicrypt.rb.  (#r1039)
  * integer/odd.rb, fixed Ruby 1.9 condition.  (#r1080)
  * class/cattr_*.rb fix require bug
  * opencascade.rb, fixed bug when accessing sub-hash.
  * typecast.rb, fixed require for string/methodize.
  * Fixed Pathname#glob to ensure use of ::File.


## 2.4.4 / 2008-09-01

Facets 2.4.4 includes a major bug fix that caused Facets not to load properly,
having to do with a Time extension. The problem has been fixed. In addition,
this release put Facets only a few pending adjustments away from full
Rails/ActiveSupport compatibility.

Changes:

* 10 Major Enhancements

  * Added string/mask providing powerful string manipulation.  (#997)
  * BasicObject is now just a synonm for BlankSlate unless Ruby 1.9.  (#1000)
  * Added Symbol#plain?, Symbol#query? and Symbol#setter?  (#1011)
  * Removed Time#to_date.
    * Due to clobberd RI Docs (!) this should have been in Lore lib date.rb
    * Moved to Lore date.rb. (#1012)
  * Re-added date.rb to lore library, and removed from core.  (#1014)
  * Much improved date.rb extension now in Lore library.  (#1027)
  * Deprecated kernel/suppress. Use Exception.suppress from now on.  (#1040)
  * Improved date.rb and moved to LORE library, and removed from CORE.  [major]
  * Deprecated kernel/suppress. Use Exception.suppress from now on.  [major]
  * Deprecated String#to_time.
    * This method reqiures the loading of a number of other standard libs.
    * We can reconsider adding it again if we decide these other libs should be core.
    * Or if we find a more suitable way to define the method.

* 17 Minor Enhancements

  * Moved style.rb to string/stylize.rb  (#998)
  * Renamed string/subtract to string/op_sub.
    Old name will remain for time being for compatability. (#1002)
  * Module#instance_method_define? now only applies to public methods.  (#1003)
  * Array#index accepts a block (one of the few core overrides).  (#1004)
  * Moved Hash#<< from hash/update.rb to hash/op_push.rb  (#1005)
  * Add facets class files (eg. facets/string) have been made dynamic.  (#1013)
  * Moved variablize methods out of metaid.rb and into separate files (string/ and symbol/).  (#1042)
  * Added Time#advance.  (#1046)
  * Added qua_class.rb. Yea. It really is my favorite.
  * Added simple functional test that loads all of Facets.
  * Added a benchmark for measuring how fast Facets loads. (Core < 1sec!)
  * Made Module#alias_method_chain a public method (for better Rails support).
  * Wrapped Nilclass#to_f in 1.9 condition.
  * float/round.rb redirects to numeric/round.rb.
  * numeric/float.rb holds rounding methods for all classed Numeric, Integer and Float.
  * Replaced Kernel#instance_exec with Mauricio's version.
  * Improved String#each_char to work like Ruby 1.9.
    * This loads strscan.rb.
    * It is wrapped in a 1.9 condition.

* 8 Bug Fixes

  * Hash#<< now returns self  (#1001)
  * OpenStruct#to_h dups internal table.  (#1015)
  * Fixed require of string/xor in bicrypt.rb.  (#1039)
  * Fixed facets.rb to use relative paths.
  * Fixed cgi.rb (CGI is a class not a module).
  * OpenStruct#to_h dups internal table.  [bug]
  * Fixed require of string/xor in bicrypt.rb.  [bug]
  * date.rb (stamp) fixed ref to constant FORMAT.


## 2.4.3 / 2008-08-14

Facets is almost fully interoperable with ActiveSupport and Ruby 1.9.
We will continue to improve this interoperability in upcoming releases.

As a REMINDER, Facets 2.4+ now encourages:

  require 'facets'

This is better than cherry-picking methods. It may seem counter-intuitive,
but it actually proves more advantages to do this for the sake of
improved interoperability. The practice of cherry-picking can become
problematic if other dependent libraries have cherry-picked different
methods. In those cases these distinctions go unaccounted and untested.

Note that this release does not include a setup.rb script. We are working
on a new version of this script, which we plan to include in the next release.

This release give special thanks to the following people for their contributions:
Ken Bloom, Nick Caruso, Evgeniy Dolzhenko, Andy Freeman, Tomasz Muras and Dave Myron.
And of course, to anyone else I failed to mention that has contributed.

(NOTE: 2.4.3's changes may actually be long to 2.4.2. Notice the releases are
only two days apart. There was an issue with 2.4.2 and it had to be replaced
immediately. So take the distinct with a grain of salt.)

Changes:

* Additions

  * Add Time#trunc and Time#round to Core.
  * Add Array#recursively and fixed bug in Hash#recursively.
  * Add Kernel#instance method which provides a fluent interface to private object space.
  * Add Symbol#plain?, Symbol#query? and Symbol#setter?
  * Add Hash#symbolize_keys and #stringify_keys.
  * Add File#split_root.
  * Add #glob and #glob_first as extensions to Pathname.
  * Add NilClass#ergo whic points back to kernel/ergo.
  * Add #bump method to VersionNumber class.
  * Add String#mask providing powerful string manipulation.
  * Add Ken Bloom's DictionaryMatcher class (will be renamed in future version)

* Deprecations

  * Deprecate Hash#keys_to_s and Hash#keys_to_sym.
    * These are the original versions of these methods.
    * But now we can use #rekey(:to_s) and #rekey(:to_sym) instead.
  * Deprecat ruby.rb, which was a sort 1.9 compatibility layer.

* 22 Major Enhancements

  * Changed File#rewrite to not use the in-place change of the string.
  * Renamed Class#to_pathname and #to_methodname to #pathize and #methodize.
  * Removed Console:: namespace for ANSICode.
  * Moved Mentalguy's lazy.rb to core!
  * Added Indexable and Stackable to core.
  * BasicObject is now just a synonm for BlankSlate unless Ruby 1.9.  [major]
  * Moved Indexable and Stackable to core.
  * Renamed arguments.rb and CLI::Arguments to argvector.rb and Argvector.
  * Added optional argument to Dictionary#first and #last.
  * Moved binding/opvars from core to more.

* 19 Minor Enhancements

  * Improved File#rootname --it is now more robust.
  * Made FileUtils#whereis a module_function again.
  * Created Lore library to house extensions to Ruby's standard library.
  * Re-added facets class files (eg. facets/string) and are now dynamic.
  * Added block to Array#index.
    * This is one of the few core overrides in Facets.
    * It is a feature already in Ruby 1.9.
  * Added Jim Weirich's BlankSlate class.
    * This is a temporary measure be compatible w/ AcitveSupport's BasicObject.
  * Split kernel/load.rb into require_all.rb and require_local.rb.
  * Split module/alias.rb up into alias_accessor, alias_module_function and alias_method_chain.
  * Renamed string/subtract to string/op_sub.
    Old name will remain for time being for compatability. [minor]
  * Moved style.rb to string/stylize.rb  [minor]
  * Added warning to bytes to use RichUnits instead.
  * Updated warn line fore eventual deprecation of fileshell and arguments.*
  * Added facets-load.rb to allow old school cherry picking.*
    * Between 2.0 and 2.4 require 'facets' simply added core to LOAD_PATH.
    * Starting with 2.4 it loads all of core automatically instead.
    * facets-load.rb provides a way to use the old behavior.
          require 'facets-load.rb
          require 'kernel/with'
          require 'symbol/to_proc'
    * This adds the path to the end of LOAD_PATH to prevent any load conflicts.

* 5 Bug Fixes

  * Fixed Time#hence changed years when changing months.
  * Fixed Time#hence to flip year correctly when adding months.
  * Hash#<< returns self
  * Fixed String#pathize.
  * Module#instance_method_defined? now only applies to public methods.

* Administrative Enhancements

  * While not perceptible to an end user, there are now 3 divisions: lib/core, lib/lore, lib/more.
  * Modified script/test to display $LOAD_PATH before running tests.

## 2.4.2 / 2008-08-12

Just some more of those great old work your ass off changes.

Changes:

* Major Enhancements

  * Added Ken Bloom's DictionaryMatcher class from Ruby Quiz #103.
    (Note this class will probably be renamed in the future.)
  * Changed File#rewrite to not use the inplace change of the string.
    * If you were using the function, change your code to use File#rewrite! instead.
    * Or, modify your code ot use the new behavior.
    * This change can make for a slippery bug, so be sure to check for it!
  * Moved live.rb to facets-live.rb.
  * Added kernel/instance method which provides a fluent interface to private object space.

* 5 Minor Enhancements

  * Added sow generation forms.
  * Spilt Time#trunc into separate file.
  * Remove old log files --shouldn't version control these.
  * Added note to FileList to add glob options parameter.
  * Added optional argument to Dictionary#first and #last.

* Other Enhancements

  * Move "lore" tests to test/lore (lore are extensions to Ruby's standard lib).
  * Added test/core, test/lore and test/more.
  * Added time/test_round.rb
  * Added array/recursively.
  * Added time/round.
  * Time#to_date makes the public (it already existed in Ruby!)
  * Fixed Time#hence to flip year correctly when adding months.
  * Work on documentation using new Sow system.
  * Moved meta.rb to more/kernel/meta.rb and merged facets/core.rb into facets.rb.
  * Added more/kernel directory --hey not every extension can be core.
  * Adjusted loadpath and moved lazy.rb to core!
  * Moved remaing files to subdirectory locations.
  * Moved most core libs to core/.
  * Move most more files to the more directory.
  * Added lore and more directories.
  * Added facets/core directory. Yes, I'm spiliting the lib again.
    * Loadpath will be used, so user inteface will stay the same.
    * Setup.rb will be adjusted to recognaize loadpath.
  * Removed Rope class. If anything this will have a separate project.
  * Moved setup.rb to script/setup.
    * This will either be replaced with configure/install scripts.
    * Or, depend on a separate ruby setup.rb project.
  * Added recorder.rb to consider in work directory.
  * Added admin directory.
  * Added "TO BE DEPRECATED" message to ruby.rb.
  * Added all methods from ruby.rb as individual core methods.
    * These are the methods that overlap with 1.9.
    * They are encased in 'unless RUBY_VERSION' caluses.
  * Imporved file/rootname --now much more robust.
  * Added Kernel#to_yamlfrag to yaml.rb as way to output yaml w/o the "---" header.
    * Perhaps not the most robust solution, but okay for now.
    * Maybe a poor name for the method, but you got a better one?
  * Made FileUtils#whereis a module_function again like it used to be. Because:
    (1) that seems to be the way most other FileUtils methods are (cd, mkdir, cp, ...) and the most
        obvious way that users would WANT to use FileUtils: FileUtils.whereis("ruby").
    (2) I see module_function used in other comparible parts of Facets: UploadUtils, ConsoleUtils,
        ZipUtils, FileUtils#safe_ln, ...
    (3) My code that relied on the old module_function behavior was breaking
        What were you thinking changing it?? ;)


## 2.4.1 / 2008-04-03

This release takes aim at improving compatability with ActiveSupport.
It also reintroduces an improved paramix.rb.

Changes:

* 4 Major Enhancements

  * A much improved paramix.rb has been returned to the library.
    * There a no longer capitialize module methods at all.
    * Use Module#[] and mixin_params[] instead.
  * Deprecated behavior.rb. It was not robust.
  * Added basex.rb, for working in any encoding base using any character set (base62 is the default).

* 3 Minor Enhancements

  * Comparing to ActiveSupport, found 63 extension clashes, but most are due to 1.9 features.
    The rest should be compatible.
  * Reatomized a number of Kernel and String methods. Reatomization is nearly complete.
  * Continued work on reatomizing core extensions (nearly complete now).


## 2.4.0 / 2008-03-24

Facets 2.4 is a major step forward for Facets. It is perhaps the release
that 2.0 should have been, but of course it took the actual 2.0 release
to make 2.4 possible. Some annoyances you may have encountered in updating
your code to 2.0 are now fixed. And from 2.4 on, Facets will now be
settling down into simple refinement release cycles for a while.

The main change under the hood is to bring everything up to the top
lib/facets/ directory. No longer are the libraries sorted by category.
I had done so for a long time to make it easier to track the various libs,
but in the end it was only making it more diffcult to deal with build tools
and packaging.

For the end-user, the largest change is a new emphisis on:

  require 'facets'

This is better than cherry-picking methods. It may seem counter-
intuitive, but it actually proves more advantantages to do this
for the sake of interoperability than the practice of cherry-picking.
The reason is simply because others may have cherry-picked different
methods, and those distinctions go unaccounted and untested.

Also with this release, to bolster the use of require 'facets',
some lack-luster extensions have been deprecated and namespace usage
has been improved. In addition, we are getting very close to full
ActiveSupport, and Ruby 1.9, interoperability. Expect this
to be complete in the next minor release or two.

Changes:

* Enhancements

  * String#to_re and String#to_rx have swapped default behaviors. #to_rx escapes, #to_re does not.
  * The Console namespace is being deprecated. command.rb and arguments.rb now use CLI naemspace.
  * #compare_on and #equate_on are now "mixin methods" Comparable() and Equateable().
  * Enumerable#product, #combintations and #permutations have change to be Ruby 1.9 compatible.
  * thread.rb, map_send, et al, block is passed to send instead of yielding on result.
  * namespace.rb has been renamed to methodspace.rb.
  * Ruby 1.9 defined a new Proc#curry method, so Facets version has been made compatible.
  * The old curry method is now called #partial, as in "partial application".
  * Deprecated interface.rb. Perhaps a better approach but nonetheless extraneous.
  * Deprecated paramix.rb. A better way is to use a capitialized methods. (Perhaps a lib for that?)
  * Brought back a few web related libs, htmlfilter.rb and cssfilter.rb in particular.
  * camelcase and snakecase are core extensions. For specialized styles use String#style in style.rb.
  * Renamed ArgVector to CLI::Arguments
  * Moved one_nine.rb to ruby.rb
  * Moved test/test_one_nine.rb to test/test_ruby.rb.
  * Updated requires for "one_nine" to just "ruby" b/c of backports to 1.8.7.
  * Added warning to Rick Kilmers's unit system.
    * Moving Rich Kilmers's units system to it's own package.
    * Three are alternate unit systems available and Facets should work with any of them.
    * Will keep a fair amount of the Time extensions though.
  * Moved nil/status.rb to nilstatus.rb
  * Got rid of Method#curry and Method#partial since they just convert to Procs.
  * Made op_esc.rb a separate module rather thanan extension.
  * Deprecated with_reader, with_writer and with_accessor for attr_singleton_reader, &c.
  * Deprecated Hash#pairs_at. Use Hash#slice instead from core.
  * Fixed the namespaces of some extensions.
  * Added prime directory and files.
  * Removed all "prime" extension files.
  * Move mattr to module.
  * Fixed require bug in time methods.
  * Reverted memomize.rb back to original code --will come back to later.
  * Added stylizer.rb to replace stylize.rb
  * Array #recursively is not only called #traverse.
  * Added case/stylize methods to more/facets/string.
  * Renamed more/string/facets/titlecase to captialize_all.
  * Added uri and xoxo tests.
  * Progressive work on memoize and elementor.
  * Functor no longer privatizes =, == and =~.
  * Properly split conversion.rb.
  * Some string methods extracted from stylize.rb.
  * Moved random.rb to more/.
  * Renamed namespace.eb to methodspace.rb.
  * Moved autoreload to more/facets/kernel.
  * Removed old curry.rb.
  * Added cgi.rb with some standard extensions.
  * Deprecated paramix.rb.
  * Added xmlhash.rb and returned uri.rb extensions to the library.
  * Added #method_name to Date class.
  * Remove cut-bases AOP, now in it's own library.
  * Converted compare_on.rb to Paramtric Mixins.
  * Split fileutils up into individual methods.
  * Renamed console.rb to what it should be consoleutils.rb.
  * Update to command.rb integrating MasterCommand and Command into a single class.
  * Added options back into multiglob_r.
  * Improved cloneable.rb to be a true deep dup/clone mixin using Ken Bloom's suggestion.
  * Added tasksystem.rb.
  * Added enumerable/combinations.
  * Added openhash and tracepoint.

* Bug Fixes

  * Fixed bug with #peek in stackable.
  * Fixed bug in Kernel#object_hexid.
  * Fixed bug in multiglob_r so it will NOT follow symlinks.
  * Fixed test_keyize.rb.

* Adminstrative Changes

  * This was a fairly large and fast-paced update, so unfortunately not all changes are listed this time.
  * Added ri generation to setup.rb.
  * Updated README and allowed doc/ to be included in package.
  * Finally completed removal of all embedded tests.
  * Organized all libs between core, more, class and mixin.


## 2.3.0 / 2008-02-01

Amoung other changes with this release, cloneable.rb is now a true deep
dup/clone mixin; tracepoint.rb returns to the library.

Changes:

* 4 Major Enhancements

  * Cloneable provides true deep cloning.
  * Moved hash_keyize.rb to CORE as hash/keyize.rb.
  * Added tracepoint.rb back to the library.
  * Added hash/collate.

* 3 Bug Fixes

  * Fixed multiglob_r bug, so it will NOT follow symlinks.
  * Added a couple of missing binding requires.
  * Fixed test_keyize.rb.

* 6 Admistrative Changes

  * Reorganized library into smaller groups: core, more, class and mixin.
  * Remove admin/svn subdir.
  * Remove admin/log.
  * Add admin tasks.
  * Moved admin tasks to admin directory.
  * Added admin directory.



## 2.2.1 / 2007-12-22

This release get rid of the underlying methods subdir.
All method redirects are now in core, to ensure there
are no more name clashes.

Changes:

* Method Renames

  * Moved string/format.rb to string/wrap.rb.
  * Updated String#brief.
  * Moved binding/cflow.rb to caller.rb.
  * Moved core hash/keyize to more.

* Other Enhancements

  * Fixed up binding extensions.

* Administrative Adjustments

  * Got rid of methods subdir. All method redirects are in core/.
  * Moved doc/wiki to apiwiki b/c of Rubyforge's wiki.
  * Removed doc/api dir.
  * Added wiki.
  * Renamed a couple test tasks.
  * Update per-module/class files.
  * Moved methods and groups task to trash.
  * Added test class/remove_descendents.rb.
  * Added all remaining per-method require libs from methods/ (will need to wrok through these over time).
  * Added trash work directory.
  * Adjust text according to per-method file changes.
  * All hash method, but the conversion methods, are now represented in core/facets/hash.
  * Added a few more Hash per-method files.
  * Add per-method libs for hash.
  * Updated facets/string.rb.
  * Renamed ROLLRC to facets.roll.


## 2.2.0 / 2007-12-13

This release provides improved rdocs and prepares facets for use with Ruby 1.9.
It also adds Matthew Harris' duration.rb library. Bug thanks to Matthew!

Changes:

* Additions

  * Added Matthew Harris' Duration class.
  * Added Hash#slice and Hash#except (didn't we have this before?)
  * Added registerable.rb, updated history.
  * Added #include_as to facets/namespace.rb.
  * Added op.rb to string.rb.
  * Added String/op.rb with String#- method.

* Method Renames and Reorganizations

  * The name Array#unzip didn't makes sense, it was renamed to #modulate (though #collate seems better?)
  * Renamed Enumerable#collate to #mash (Map hASH); #collate and #graph remain aliases for the time being.
  * Renamed accessor #attributes to #instance_attributes.
  * Renamed Enumerable #collate to #mash. (old name, along with graph, will be an alias for time being)
  * Divided enumerable/collect into split.rb and each.rb as well.
  * Moved mapsend.rb to thread.rb.
  * Updated mapsend.rb to focus on threads.
  * Moved continuation extensions to more lib.

* Deprecations

  * Deprecated Module#include_and_extend. Just use both silly.
  * More lib pp_s.rb has been removed. Use #pretty_inspect instead.
  * Removed continuation from core.
  * Removed pp_s.rb (use pretty_inspect) add continuation.rb.
  * Remove kernel/require_esc.rb.

* Other Enhancements

  * integer/bitmask.rb has changed a bit --pun intended ;) Deprecated some methods and now use "~" instead of "-" to clear bits.
  * Split binding extensions up a bit more finely --eval.rb sprouted here.rb, self.rb and defined.rb.
  * Move Time#stamp out of conversion.rb and into time/ dir, and remove to_s alias.
  * Preliminary addition of Matthew Harris' excellent duration.rb lib (will integrate with times.rb better in future).
  * Minor edit to basicobject.rb in light of 1.9.
  * Minor adjustments to lazy.rb to fix warnings by Ruby 1.9.
  * Added if clauses to handle upcoming Ruby 1.9 gracefully. Facets should now be just about ready for use with 1.9.

* Documentation Enhancements

  * A lot of rdoc updates to core extensions --as promised ;)
  * Just about every method now has at least a brief explinaiton and an example.

* Administrative Adjustments

  * Moved task/config.yaml to meta/ per new Ratch.
  * Moved task/special to task/doc.
  * Updated todo list (in dev/).
  * Copied log/history.rd to CHANGES.
  * Removed log/history.rd and log/todo.rd
  * Fixed stylize.rb for use with 1.9 (fixed case statement).
  * Separated kernel/returning, now that #tap will be in 1.9.
  * Updated facets.rb for use with 1.9.
  * Separated time/stamp.rb.
  * Divided binding up into a few more pieces.
  * Fixed kernel/instance to play nice with 1.9.
  * Added test for string/op.rb.
  * Added test_collect.rb split-offs and test_mash inplace of test_collate.
  * Cleanup test headers.
  * Added 1.9 check in continuation/create.rb.
  * Add a couple new task for rdoc gen.
  * Added nbsp to quickopts task.
  * Work on website using siteparts.


## 2.1.3 / 2007-11-28

This release fixes four bugs --one being fairly serious, as it prevented
require 'facets' from working at all.

Changes:

* 4 Bug Fixes

  * Fixed oddity in Enumerable/collate.
  * Fixed issue that prevented loading of facets.rb.
  * Array#to_h used flatten, but it needed to be flatten(1).
  * Move core/main.rb back to core/facets.rb as it conflicts with lib in more/.


## 2.1.2 / 2007-11-22

Changes:

* Additions

  * Added Exception#details.

* General Enhancements

  * Dir::multiglob no longer handels -/+ modifiers. Use FileList instead.

* Administrative Adjustments

  * Fixed task/install script.
  * Improved task/changes.


## 2.1.1 / 2007-11-16

Changes:

* Additions

  * Added kernel/ergo.rb.
  * Added pp_s.rb (Questionable addition, but we'll leave it for now.)
  * Added validation.rb. This is here for Nitro's sake --better techinques may replace it in the future.
  * Added Console::Logger to logger.rb (may be separated in future).
  * Added option arity to command.rb.

* Deprecations

  * Removed tracepoint.rb.

* Bug Fixes

  * Fixed bug in command.rb that clobbered options.
  * Fixed options bug in command.rb.


## 2.1.0 / 2007-11-10

Major changes include a new and much-improved command.rb, a new BiCrypt
class for simple two-way crypotgraphy, as well as attr_reader!, 
attr_writer! and attr_accessor! for flag attributes, plus 
alias_xxx methods for all attr_xxx methods.

Changes:

* Additions

  * Added BiCrypt class for simple two-way encryption.
  * module/attr.rb now has attr_reader!, attr_writer! and attr_accessor!
  * All attr_xxx methods have coresponding alias_xxx methods.
  * Added UniversalOptions module.
  * Added "tester" attribues attr_xxx!. Also added alias_xxx for all attr_xxx methods.

* Enhancements

  * command.rb has been completely rewritten. The API has changed completely!
  * There is no longer a Commmand::Optoins class. Use Console::Arguments instead.
  * Moved common alias methods from attr.rb to alias.rb.
  * MasterCommand now passes (args, opts), until 1.9 is main stream.
  * Cleaned up enumerable/permutation.rb
  * Added -q option to zip method in ZipUtils.
  * Ok. #p is back. This will in fact be in 1.9, so we're good.

* Bug Fixes

  * Fixed bug in Enumerable#cluster_by which returned nil instead of [].
  * Fixed minor bug in arguments.rb that prevented proper repeat parameters.
  * Fixed bug in to_console.
  * Fixed bug in enumerable/cluster_by (returned nil instead of []).
  * Fixed bug in Hash#- Thanks to Xavier Shay.
  * Fixed to_h in Command::Options

* Admin Changes

  * Added dev/test
  * Renamed RELEASE to WHATSNEW
  * Added injecting test and cleaned up.
  * Added comment for potential future #is.
  * Added top-level log directory.
  * Remove #q reference from RELEASE.
  * Cleanup of test_initializer.rb.


## 2.0.5 / 2007-11-07

Minor release that fixes a couple of bugs and adds the last of
adopted methods from Gavin Sinclair's Extensions project.

Also, renamed #p to #q, because of multiple args problem. 
I don't know how Ruby 1.9 plans to handle multiple args.
Will deprecate for 1.9 anyway so doesn't matter much.

Changes:

* Additions

  * Added final methods Gavin Sinclair's Extensions project. (Noah Gibbs)

* General Improvements

  * Made #alias_method_chain compatible with current ActiveSupport version.
  * Rename #p to #q, because of multiple args problem.
  * Allow Class#initializer to return the attribute names.

* Bug Fixes

  * Fixe return bug in hash/op.rb.
  * Fixe bug with Dictionary#initialize.
  * Fixe bug with Hash#-. (Xavier Shay)

* Admin Adjustments

  * Fixed package name in icli.yaml.
  * Added name field to meta/icli.yaml.
  * Added meta/icli.yaml.
  * Added a RELEASE file to hold current release notes.
  * Added log task.
  * Added changelog file in doc/log/.


## 2.0.4 / 2007-11-04

Changes:

* Unsorted Changes

  * Up'd version to 2.0.4.
  * Update task/groups.
  * Removed extest task. We will no longer need it.
  * Minor update to rdoc.yaml.
  * Renamed old changelogs.


## 2.0.3 / 2007-11-02

Changes:

* Unsorted Changes

  * Touch up to methods task.
  * Update rsync filter
  * Minor updates fixing issues highlighted by running crosstest.
  * Many minor bug fixes after running against crosstest.
  * Added usage support for __foo options.
  * Fixed a many a test after running against crosstest.
  * Removed load task. It did not isolate the libs, so wasn't effective.
  * Added a number of new tasks.
  * Rename SMTP_TLS to Smtp_tls for Rdocs.
  * Moved rdoc.yaml to config/.
  * moved task/config to task/config/general.
  * Update tasks.

  * Added array/only,  symbol/to_proc (where did it go?) and hash/select.

  * Update roll file.
  * Moved test_command_options to test_command.
  * Update dictionary test to check dup and autohash.
  * Fixed autohash and dup bugs.
  * Verbatim support for Rails' version of #alias_method_chain.
  * Remove site/ directory.
  * Moved rsync filter up too.
  * Moved doc/site/ up to doc/.
  * Added javascript directory to doc/.

  * Updates across the board.
  * Updates to stylize and command.rb.
  * Made facets.rb a shortcut to facets/facets.rb (this is for Rolls, better way?)
  * Oh smack. Lots of stuff fixed.

  * Remove version.txt. No longer needed.
  * Removed meta/project.yaml, replaced by facets roll file.

  * Modifications to command.rb, snapshot and rbsystem.
      * Merged command.rb and command_options.rb into command.rb.
      * Added to_data aliases to snapshot.rb
      * Minor additions to rbsystem. Rather than System, maybe Ruby?

  * Removed embedded test from overload.rb.
  * Allow OpenStruct#initialize to take a setter block.
  * Downloader needs 'wb' flag rather then just 'w'.
  * Fixed typo and removed embedded test.
  * Fixed bug in command_options.rb, putting the class back in the Console namespace.

  * improved module/traits.rb


## 2.0.2 / 2007-10-08

Changes:

* Administrative Changes

  * Cleaned up some test and updated version to 2.0.2
  * Update methods to eleminate duplicate file names between lib/core and lib/methods


## 2.0.1 / 2007-10-06

Changes:

* Unsorted Changes

  * updated version to 2.0.1
  * minor bugs fixes
  * update methods task to display each file as it process it
  * added benchmarks for some enumerable methods.
  * moved demo/bench/bench_factorial to an demo/bench/integer subclass
  * added Erik Veenstra to AUTHORS for work on enumerable/group_by and cluster_by
  * minor improvement to test task to specifically read test_*.rb files
  * removed enumerable/partition.rb
  * move enumerable/partition.rb methods to collect.rb.
  * Improved Integer#of.
  * Minor improvements to collect.rb and partition.rb
  * Deprecated nonuniq!, bug fixed cluster_by and aliased group_by and partition_by.
  * Renamed Enumerable#partition_by to group_by (like Ruby 1.9) and fixed bug in cluster_by.


## 2.0.0 / 2007-10-02

Changes:

* General Enhancements

  * Added Oliver Renaud to the AUTHORS list (oops!)

* Bug Fixes

  * Fix requires in `cut.rb` and `attributes.rb`.
  * Fix `String#brief` in `format.rb`.

* Unsorted Changes

  * removed 1stClassMethod from "more" docs
  * removed 1stClassMethod as a rdoc target (now in Core target)
  * update install and rdoc tasks
  * moved string/test_index.rb to string/test_nchar.rb
  * updated indexable tests
  * update string.rb to include string/nchar.rb
  * moved index.rb to nchar.rb
  * clean up string/index.rb
  * moved facets.rb to fore directory
  * add comment to groups task
  * added groups task
  * updated all extrension group files (array.rb, binding.rb, etc.)
  * uncapitalize meta files
  * update methods task a bit more, plus related configuration
  * updated methods task
  * removed lib/core --this is generated content (may be renamed too)
  * added load and stats tasks
  * update install task --this replaces setup b/c of Facets' special install needs
  * update project file
  * removed lib/facets
  * moved remaining libs to fore (will later consider an additional subdivision)
  * move facets/fore to fore/facets
  * move facets/more to more/facets
  * added ;ob/core, more and fore
  * move memorize
  * removed io and net directories
  * moved io/redirect.rb to more/ioredirect.rb and net/smtp_tls.rb and net/uploadutils.rb libs to more too.
  * few more libs moved to more/ directory
  * moved all the most obvious more libs to the more directory
  * moved fore "grouping" libs to fore directory
  * moved "fore" libs to fore directory
  * create for and more directories (yes, you know what's coming ;)
  * renamed remain.rb (was main_as_module.rb) to just main.rb
  * improved rdoc task and project.yaml file
  * better docs for OpenObject
  * improved method hiding
  * documentation touch ups
  * fixes for conversion.rb rather than conversions.rb
  * updated to website docs
  * moved demos to demo/sample
  * added bench and sample dir to demo
  * moved spy.html to light.html
  * menum change to webpage, fixed core doc link
  * moved metadata files to meta/ (info/ or box/ would be better?)
  * updated test_conversion.rb for to_h/to_hash
  * reverse_each instead of each for after advice in advice.rb
  * final fix to to_h/to_hash discrepency
  * added a Path and Root features to Pathname (good idea?)
  * update advice.rb test and moved old cut test to dev/scrap
  * updated advice; removed preinitialize.rb to trinkets project (it was too expiremental)
  * command_filter.rb needs to considered/developed; moved to dev/new/
  * fixed interface.rb fo singelton methods
  * updates to tests
  * whole lot of small bug fixes
  * add tests to revision control
  * removed old cut test (moved to dev/scrap)
  * working on tests
  * added read.rb (taken from readwrite.rb)
  * split readwrite.rb into read.rb and write.rb
  * remove string/unpack.rb, offset can be had using '@' format instead
  * renamed conversions.rb to conversion.rb, fixed some requires
  * improved attr.rb
  * some cleanup of enumerable extensions
  * setup annotations demo
  * add non-embedded tests
  * finally brough over toadcode prototype.rb and cleaned it up enough to be useful
  * removed annotations subdir
  * moved annotations/ann.rb and attr.rb to annotations.rb and attributes.rb
  * remove annotations.rb
  * moved annotations/settings.rb up a dir
  * remove settings.rb
  * chnaged multiton_id(e) to multiton_id(*e,&b)
  * updated test task
  * added Christoph Rippel to authors lists
  * added doc header to new multiton class
  * update to new version of multiton
  * playing around with multiton2.rb
  * renamed dev/try to dev/new
  * created dev/old to temporarily house old versions of libs that have been replaced.
  * fixed quick.html documentation
  * used old wiki.gif as email.gif instead
  * fixed config.yaml publish entry
  * some minor updates to index.html
  * moved site to doc/site
  * update to publish task
  * updates of tasks
  * added kernel/report.rb to hold debug/warn extensions.
  * renamed reporting.rb to silence.rb
  * update reporting.rb (created report.rb from it)
  * task work
  * clean up dev finis
  * cleanup dev just a bit more
  * continue cleanup of dev directory
  * moved dev/twiki to misc/
  * removed dev/core
  * moved require_directory.rb to misc/
  * added dev/misc for code scraps that might be useful but are not straight lib or task code
  * more dev changes
  * organize dev better
  * cleanup of dev continues
  * cleanup of dev dir
  * clean up dev dir more
  * some cleanup of dev directory
  * almost completed advice lib
  * added comment about possible update
  * deprecate instance_send and instance_map
  * work on rdoc task
  * work on rdoc task
  * added dev/cut dir
  * no reason to track .config
  * clean up trunk
  * added todo comment
  * added advice.rb to replace old aspects.rb
  * removed aspects.rb (sucked), added prototype.rb (infancy) and adjusted to class_extension.rb
  * removed #to_roman (now part of the English project)
  * cont. work on aop and cuts
  * fixed IMG tag bug
  * added yaml.rb
  * move #here convenience method to binding/eval (separate?)
  * added in order to remove kernel/misc.rb
  * consolidate string/regesc
  * added module/methods
  * updates to include and attr
  * fixed Range#umbrella
  * more organization of docs
  * orginizing docs
  * update val.rb
  * added proc/fn.rb (from kernel/misc.rb) and fixed typo in compose.rb
  * moved misc.rb to val.rb
  * better organization of some kernel methods
  * moved #here alias to eval.rb
  * minor updates and some bug fixes (modspace what broke)
  * removed file/yaml.rb in favor or just yaml.rb
  * moved this to facets/yaml.rb
  * work on aop system
  * Added aop.rb, and cut.r and recursive.rb
  * moved cut.rb to dev (old version will be deprecated)
  * added to_hash to Dictionary, and minor mods to others
  * oops, no need for enumerator directory
  * moved threaded_send.rb to mapsend.rb
  * moved threaded_send out of enumerable/ dir
  * updates to elementor.rb
  * merged instance_map into threaded_send
  * removed map_send
  * merging map_send with threaded_send
  * cont work on elementwise methods
  * divide elementwise functions betwee two libs
  * uniq.rb is merged into count.rb
  * removed count.rb (uniq.rb will become count.rb)
  * continued refinement of enumerable extensions
  * general improvements to the organization of enumerable extensions
  * removed facets/cli dir
  * moved all cli libs from facets/cli to facets/
  * moved cli support files to facets locations
  * moved cli lib to facets main (also modified functor)
  * renamed hash/reverse to hash/merge (it contains #reverse_merge)
  * remove instance_intercept (moced to Trinkets project)
  * continued modification of those tasky tools
  * removed lib/more (this is it!)
  * moved M-Z of more/facets to facets (this is it!)
  * moved A-L of more/facets to facets (this is it!)
  * removed lib/core (this is it!)
  * moved lib/core/facets.rb to lib/facets.rb (this is it!)
  * moved lib/core/facets to lib/facets (this is it!)
  * added file/yaml.rb
  * added a list of libraries considered "core"
  * continued work on build tools
  * change tools for core/more convergence (so help us god!)
  * added conversion requirement to some core libs
  * update methods task
  * update quick.html to mirror rdoc changes --still needs work though
  * remove old rdoc task
  * added rdoc section (minimal) to tool/config.yaml
  * nope. remove site/rdoc
  * add rdoc dir, should we?
  * remove site/rdoc in preperation for new way
  * facets.rb belongs to core/
  * renamed some doc files
  * removed src/core
  * move src/core/lin to lib/core
  * added kernel/constant
  * remove src/core/web
  * moving more of core to top-level (svn sucks!)
  * moving core support files to top-level
  * removed src/more
  * move src/more/lib to lib/more
  * made lib dir (to replace src)
  * added settings.rb which points to annotations/settings.rb
  * moved svn to annotations/ subdir
  * moved dev files to top-level as part of more transition
  * temporarily removed dev/more
  * moved annotations demo to demo dir
  * added demo folder
  * add dev/more
  * remove struct again! (stupid svn)
  * moved file to top-level doc as part of more transisiton
  * bullshit svn crap
  * ann moved back to more (strongly considering annotations for it's own project)
  * build moved back to more
  * aop moved back to more
  * cast moved back to more
  * crypt moved back to more
  * exts moved back to more
  * file moved back to more
  * meta moved back to more
  * misc moved back to more
  * model moved back to more
  * struct moved to back to more
  * moved sync back to more
  * moved commandoptions.rb to command_options.rb
  * rewrote command and command options libs
  * initial Subversion import


## 1.8.54 / 2007-03-21

The following list of changes also includes changes from intrim releases,
`1.8.51 / 2007-02-19`, `1.8.49 / 2007-02-16`, `1.8.20 / 2007-02-06` and
`1.8.8  / 2007-01-31`. Unfortuantely the transition form darcs to git, 
led to some information loss in this regard.

Changes:

* Unsorted Changes:

  * added reqiure to ostruct.rb test
  * fix to command.rb's initializer
  * fixed bug with times.rb beginning_of_year and beginning_of_month
  * replaced pqueue and heap with new working class (thanks to Olivier Renaud)
  * fixed bug in ormsupport.rb (this will be moved out of facets in next release)
  * added empty? to dictionary (removed old subclass of Hash)
  * significant improvements to command.rb thanks to Tyler Rick
  * added tests to elementwise and tap
  * fixed test for elementwise and op_tilde_self
  * added enumerable/map_send
  * added thread_map and thread_map_send thanks to greg
  * added operator "~@" for enumerable/elementwise
  * added more/consoleutils.rb
  * added string/cleave
  * added capitalize_all thanks to Richard Laugesen
  * cartesian_product is an alias of enumerable/cart
  * added array pad thanks to Richard Laugesen
  * added kernel/tap
  * fixed test/unit load issues
  * converted facet/ requires to facets/core or facets/more as needed
  * further improvements to arguments.rb (looking good!)
  * improved symbol/self/generate
  * bug fix kernel/autoreload arguments needed to be in opposite order
  * add to_xoxo
  * removed bad character codes in multiplier.rb
  * used yaml to allow json.rb to work for all object in general
  * improvements to functor (note: is to_a and to_proc okay?)
  * add test to string/bytes.rb
  * bug fix to nilclass/op_cmp
  * fixed enumerable/op_pow to use enumerable/cart
  * added array/op_div
  * adjustments to xmlbuilder and htmlbuilder dur to buildingblock changes
  * improved buildingblock.rb
  * simplified interface of arguments.rb (still a little more to do)
  * improvements/simplifications to Dir.multiglob
  * added new authors to list
  * fixed misspelling of behavior.rb (was bahvior.rb)
  * removed #own from base list in facets.rb (really need a standard for "singleton class")
  * minor adjustments to uploadutils
  * fixed bug in aspects.rb that would not handle args of wrapped method
  * Symbol#to_s optimization, had to remove freeze
  * updates to fileutils/stage (stage worth keeping?)
  * update to credits
  * fix bug in kernel/ask, returns more than one character
  * cleanup of enumerbale/graph (no effective change)
  * new super fast enumerable/cart by Thomas Hafner (replaces #cross)
  * improved multiglob rountines (accept '+' and '-' prefixes)
  * No longer will track project file via scm until it settles
  * fixed bug in attr_tester, thanks Dov!
  * added weekdays to times.rb thanks to Ryan Platte and Dave Hoover
  * improvements to dictionary.rb (no longer a subclass of Hash) thanks Jan!
  * re-replace openhash with openobject
  * improvements to ann.rb and ann_attr.rb. works, yea!
  * fixed bug in string/singular.rb
  * changed enumerable/cross into enumerable/cart and cartesian_product
  * openobject returns (openhash was a bad name, thanks george)
  * moved enumerable/cross to enumerable/cart (cartesian_product)


## 1.8.0 / 2007-01-24

The list of changes also includes intrim releases `1.7.46 September 8, 2006`,
`1.7.38 August 31, 2006`, and `1.7.30 August 23, 2006`.

Changes:

* Additions

  * Add facets/automatic.rb, very cool, albiet experimental, way to load core methods automatically!
  * added hash/insert; like store but only if key isn't already present
  * added module/include_and_extend
  * added File::mulitglob_sum; accumulates file patterns, and accepts '+' and '-' prefixes
  * added module/module_method; like module_function but makes method public
  * added module/include_function_module; attempts to properly include one function_module into another
  * kernel/yaml convenience method for YAML::load
  * added kernel/supress; supress errors while executing a block (nice DHH!)
  * added symbol/chomp, like string#chomp
  * added proc/to_h; converts an assignment proc into a hash
  * proc/bind; bind a proc to an object, returning a method
  * added module/prepend; provides dyanamic method wraps for modules, and static wraps for classes
  * added module/new; use a module as if it were a class
  * added module/alias_accessor
  * kernel/instance_class; yet anouther meta_class name, but a more sensicle name this one
  * added kernel/populate; populates an object's inst. vars from a hash or assingment block
  * added kernel/daemonize; one last thanks to DHH!
  * added enumerable/injecting; like inject but automatically returns the memo from the block
  * added kernel/object_send, a true public-only send method
  * added kernel/silence_stream; output to null device; thanks DHH!
  * added kernel/instance_values, thanks DHH!
  * added Config:inspect for rbconfig
  * added hash/pairs_at (aking to values_at)
  * added _why's metaid methods (meta_class, meta_eval, etc.)
  * added kernel/enable_warnings to complement silence_warinings
  * added integer/to_roman
  * added logical operators for hash (and/or)
  * array/to_path convert ans array to a path string
  * array/index takes a block
  * added fileutils/compress; very simple convenience methods for archiving folders
  * added fileutils/stage adn staged, a means of transfering files accoring to preset rules
  * added kernel/ask, simply command to get console input
  * added populate.rb, mixin for classes that need on a basic initializer
  * added version_number.rb (a specialized tuple)
  * added uploadutils.rb
  * added Joel VanderWerf's great script.rb script
  * added Austin's minitar.rb --it's just too damn useful!
  * added htmlfilter.rb very nice html escape class
  * added dependency.rb, allwos method to have dependend execution (like rake tasks)
  * added arguments.rb this is for parsing console command arguments
  * add new version of annotations: ann.rb and ann_attr.rb
  * added File::yaml? to roughly detect if a file is a yaml file

* Renamed Features

  * Rename #superior to #super_at.
  * OpenObject = OpenHash (OpenObject will eventually be deprecated)
  * renamed quaclass to qua_class
  * renamed openobject to openhash !!!

* Deprecations

  * had to remove taskable.rb for now (implementation won't work as toplevel include)
  * deprecated (yored) kernel/own, yet another term for the singleton class
  * removed dataobject.rb (was never used)
  * deprecated (yored!) module/inject; what a silly method
  * deprecated kernel/require_facet (no longer needed)

* Bug Fixes

  * Fix enumerable/partition_by.
  * memoize should now work at toplevel
  * minor bug fix to httpaccess

* General Enhancments

  * Add buildingblock.rb, replacing builderobject.rb.
  * HtmlBuilder and XMLBuilder aer now based on BuildingBlock
  * adjust require for "yored" files
  * minor improvements to basic object (object_self to access kernel methods)
  * ostuct adjustment, use #instance_delegate to get underneth the open access
  * module/include_as is now based on module/namespace (thanks Pit!)
  * minor adjustments to methods for (class<<self;self;end)
  * facets.rb now references facets/sys.rb
  * adjust old annotation.rb (now in yore) to use openhash

* Admin Adjustments

  * further updates to project info file (need to stop versioning this)
  * deprecated (yored) builderobject.rb (poor implementation)
  * moved deprecated #facet_require to yore lib
  * minor doc change to instance_intercept.rb
  * doc change to methodfilter.rb (maybe deprecat in future)
  * moved old module/namespace implementation to yore

* Unsorted Changes

  * moved plugin.rb to ratchets/library project
  * proper credit for multiton goes to Ara T. Howard!!!! Also improvements.
  * remove library.rb (move to ratchets/library project)
  * updated autovivify.rb to use openhash
  * improvement to command.rb
  * imporved time/stamp
  * reimplemented proc/to_method for more sensible behavior
  * reimplemented module/namespace, very clever thanks to pit captain
  * added module_load and module_require, e.g. load into and require into
  * reimplemented instance_exec, should be much improved
  * doc updates to inflect.rb
  * updates to Hash op_add, reverse_merge, and rekey
  * each_slice is now just an alias via enumerator & fixes to partition_by
  * minor adjusment to multiglob
  * modified all.rb (not recommended!) to require facets/sys
  * modifications to project information file (should this be versioned?)
  * created yore lib to store deprecated features (good idea!)
  * modified PROJECT info file
  * added module class/module_load and _require
  * remove facet/ redirect lib from darcs repository
  * OpenObject is now OpenHash (OpenObject still exist for backcompat)
  * kernel/returning is a stub for kernel/with
  * added proc/update as alias for #call per Tim Pease use of Proc as Observable
  * added behavior.rb by Nobuyoshi Nakada (plan to improve)
  * rewrote taskable.rb using classes to represent tasks; it is much improved
  * openobject.rb doc updates
  * major update to functor which is now a subclass of Proc (should be faster)
  * improvements to dictionary.rb to go along with additions of first and last
  * small improvements to command.rb
  * removed uses of __class__ for object_class and solidified usaged of #as in basicobject.rb
  * deprecated ostruct shadow methods (i.e __table__) in favor of #instance methods
  * added test to module/alias_method_chain
  * imporvements to instance_exec thanks to Mauricio Fernandez
  * improvements to kernel/send_as
  * improvements to kernel/as
  * minor doc addition to kernel/as
  * fixed syntax in hash/op_add.rb
  * imporvements to hash/partition_by thanks to Gregory of Laurel
  * added Mauricio Fernandez to authors
  * added addtional work library lore
  * moved "calibre" project information files
  * moved a number of "in the works" libs to ToadCode project
  * removed predicate.rb, an expiremental logic system, and moved to ToadCode
  * Added plugin.rb, an indirect require mechinism, ie. a plugin system
  * remove one.rb and moved to ToadCode project, this was just silly/fun library
  * Added library.rb which is a library ledger system (used to be roll.rb)
  * added kernel/with which instance_eval's a block on with's subject
  * rekey is an improved version of normalize_keys (ie. the basis of symbolize_keys)
  * multiglob is like glob but handles a list of patterns
  * proper access to openstruct's underlying table
  * minor adjustment to taskable.rb
  * minor adjustment to #dresner docs
  * minor adjustment to #as
  * simple doc addition to setup.rb
  * doc fixes and losening toplevel constraint to Object in taskable
  * made OpenObject #update and #merge public; added to_hash
  * minor "public" fix to main_as_object
  * removed unorder_store and store_only; added first/last to dictionary
  * continued improvements to command.rb
    added some new callbacks such as option_missing;
    also handles method_missing properly now
  * minor adjustments to module::@+
  * added string/rewrite
  * test fixes to module/include_as
  * documentation fix for class_extension
  * minor edit to supermethod (also finish #superior removal)
  * cleanup kernel/set_with code
  * update kernel/metaclass can now take a block
  * added hash#+ and hash#- (op_add and op_sub)
  * added cache to enumerable/every
  * minor updates to facets.rb
  * removed kernel/superior (silly name)
  * minor modifications ot PROJECT file
  * [add] more/autovivify.rb expiremental lib.
  * [update] Minor fix to command.rb to not use Kernel methods as subcommands.
  * [update] Work on annotation.rb to improve support for :self.
  * [deprecate] enumerable/permute.rb (replaced by permutation) and minor test fix to linkedlist.rb
  * [added] linkedlist.rb (thanks Kirk Haines!)
  * [added] enumerable/sum (thanks to Gavin Kistner)
  * [added] array/each_combo and combos (Eunumerable.combinations will be deprecated eventually)
  * [rename] changed enumerable/permute to permutation
  * [update] annotation.rb, fixed :self key
  * [added] pathname/op_div
  * [deprecated] hash/each.rb
  * [removed] hash/each.rb, this variation of Hash#each is too "dangerous" in practice
  * [update] module/self/op_add.rb: fixed inclusion order
  * annotation.rb, return annotations of self when key is :self [updated]
  * module/self/op_add.rb and op_sub.rb - traits like features [added]
  * minor improvemtns to module/clone_using and integrate
  * command.rb: minor change to docs [update]
  * openobject.rb (added NilClass#to_openobject) [update]
  * enumerable/each_slice.rb [replace]
    Ruby already has #each_slice if you require 'enumerator'. And for 1.9,
    I believe, this will be present automatically. So Facets' each_slice
    has been replaced with a simple redirection to require 'enumerator'.
    Ruby's version is slightly different in that it won't check arity if
    a slice count is not given. For this, use enumerable/each_by.
  * array/delete_at.rb [removed]
    Ruby's Array class already has a #delete_at method,
    although this is another method at odds with Hash.
    Use #delete_values_at instead.
  * moved File.bitbucket to File.null (but bitbucket was so "fun"! ;)
  * added nilclass/to_path
  * added kernel/load_local
  * added kernel/callee
  * added enumerable/eachn, integer/each and integer/of
  * re-added array/delete_values_at
  * added filetest/self/root
  * added cache.rb
  * moved Dir.bitbucket to File.bitbucket
  * removed task file in favor of sake based util/
  * added main_as_module
  * added doublemetaphone (Thanks Lawrence Philps!)
  * rewrote taskable.rb
  * minor doc fix to association.rb
  * added symbol/to_s which caches the result for speed up
  * additions and adjusments related to hash/delete_at
  * added Dir.bitbucket
  * update to array/op_fetch to include op_store
  * updated docs and util tasks
  * minor changes
  * added filesystem.rb
  * taskable should now work at the toplevel too
  * still working the organization as Reap/Sake change
  * started setting project tasks up for sake
  * updates to enumerable each_slice
  * updated names of meta files
  * added trace to command.rb
  * organizational changes


## 1.7.0 / 2006-07-25

Changes:

* Additions

  * Add Infinity class.
  * Add `tkxml.rb`.
  * Add singleton Annotations.
  * Add Cuts implimentation.

* Improvements

  * Improve command.rb with error catch. (Jonas)
  * Improve #wrap_method, no need to undef method before redefining.
  * Improve String#singular and plural.
  * Improve #normalize_keys to take a proc instead of a "send" parameter.

* Bug Fixes

  * Add #to_a to OpenObject.
  * Fix instance_interception test.

* Miscellaneous Enhancements

  * Add hash/op_div.rb and array/op_div.rb.
  * Allow tasks to do arguments (all dependent tasks must take same args)
  * Separated integer/op_mul from compose, op_mul now composes and Integer#of.
  * added work dir to repo
  * doc cleanup
  * remove kernel/called and fixed callee,__callee__ and __method__.
  * just about prefected OpenObject
  * keys_to_sym to symbolize_keys usage
  * remove explore dir, perhaps better to do without midstage



## 1.6.0 / 2006-07-20

Changes:

* Additions

  * Add `PrivateAccess` expiremental class.
  * Add `Hash#reverse_merge` (from ActiveSupport).
  * Add core methods `Enumerable#divide`, array and hash op_div, kernel/meta.
  * Add Jan Molic's Debugger(Logger) to explore.
  * Add `Symbol::generate`.
  * Created subclass `AutoDictionary`, now used by `Dictionary.auto`.
  * Add new implementation of `OpenObject` in Facets/EXPLORE.
  * Add `deep_clone` (thanks Jan Molic).
  * Add `Hash.auto` (thanks Jan Molic).
  * Add `annotation` and `instance_intercept` to Facets/EXPLORE.
  * Add `Kernel#to_data`.
  * Add Daniel Berger's `Hash#to_stuct`.
  * Improve `Proc#to_method` and `Kernel#instance_exec`.
  * Add `instance_exec` (duh).
  * Add `object_clone` and `object_dup`. These object_ methods are intended
    as non-overridable (although you can if you must).
  * Add facets/explore libs.
  * Add settings.rb from glue.

* Renamed Features

  * Retained `::alpha` but changed `::auto_key` to `::auto_alpha`.
  * Rename Hash methods `keys_to_s` and `keys_to_sym` to `stringify_keys`
    and `symbolize_keys`. Both now depend on `normalize_keys`.

* Deprecations

  * Deprecate BasicObject (bad implementation).
  * Remove BlankSlate alias to BasicObject.
  * Remove generate_method_name methods
  * Remove kernel/generate_method_name, not thread safe.
  * Remove moodule/generate_instance_method_name, not thread safe.
  * Deprecate generate_method_name and generate_instance_method_name.
  * Deprecate `::key_new` and `:value_new`, use ::new.by_key and ::new.by_value instead.

* Bug Fixes

  * Fix to nilclass#status (accept single parameter).
  * Adjustments to stringify_keys, record normalize_keys.
  * Minor bug fix to `alias_method_chain`.

* Other Enhancments

  * Updated Dictionary class.
  * Work on OpenCascade, and `Hash#having_fallback` features.
  * Minor update to tagiterator.rb.
  * OpenObject uses `self[]` instead of `@table[]`.
  * Rewrote openobject as a subclass of Hash with a method filter.
  * Rewrote annotation.rb and moved into more/.
  * Move ValueHolder in snapshot.rb to Snapshot::ValueHolder.

* Admin Changes

  * Add meta docs to darcs.
  * Add _darcs expection to FileList.
  * Fix compatiblity with Reap.


## 1.4.5 / 2006-07-05

Changes:

* Additions

  * Add NilClass#status which allows a message to be passed through a failure chain.
  * Add Module#alias_method_chain from Rails as a cleveridiom for module-based method wrapping.
    A limited solution, but since there's no standard solution as of yet, well support til then.
  * Add Enumerable#cascade, cascade a list of actions on each  element of an enumerable.


## 1.4.4 / 2006-07-03

Changes:

* Bug Fixes

  * The `#method missing` in HtmlBuilder effected by BasicObject fix
    (use __self__.method instead of __method__).

* Improved Features

  * Update Functor, by adding `@self = function.binding.self`.

* Renamed Features

  * Change WebAgent to Web.

* Deprecations

  * Removed hash/keys_to_iv b/c it is a poor name. Since the alternative
    of #keys_to_instance_variables conveys the wrong idea, decided to just
    get rid of this. Instead use the hash#variablize_keys which is also
    Rails compatibile.


## 1.4.3 / 2006-06-27

* Administrative Adjustments

  * Move ProjectInfo to proj/info.
  * Better arrangment of repository,


## 1.4.2 / 2006-06-21

This release makes adjustments to BasicObject, further reducing unhidden
methods. Among them __object__, __method__ and #as. Also added `#method_missing`
that detects shadow methods and rebinds them to Object. Keep in mind that woun't
help you if you override method_missing which is typical for this class.

This release also marks the first use of Darcs version control manager!

Changes:

* Improvements

  * Adjusted BasicObject slightly, further reducing unhidden methods.

* Bug Fixes

  * Fixed bug in BasicObject#__self__.

* Administrative Adjustments

  * Started using Darcs --finally!
  * Transition to Darcs has interupted ChangeLog though :(


## 1.4.0 / 2006-05-05

Changes:

* Additions

  * Added Cookie, HTTP and HTTPAccess of ...'s library.
  * Added OpenCascade, which is like OpenObject but chains access.
  * Added MenTalguy's lazy.rb which include's Future and Promise classes.
  * Added task.rb, which provides a Rake interface compatible task
    system, but that can be used in any code.

* Improvements

  * Improved Hash#traverse (it now does all traversing before yielding).
  * Console::Command also now supports run-on flags (eg. -xvzf).
  * Updated tuple.rb so that when a string is converted to a Tuple (#to_t)
    the values wll be made integers if they are composed of only numbers.
    If you need all strings you can use a block since the block bypasses
    this auto coercement, eg. to_t{ |v| v }.

* Renames

  * OpenObject's __get__ and __set__ methods have been changed
    to __fetch__ and __store__ to correspond to the Hash methods.

* Depreacetions

  * kernel/me, kernel/methodname and kernel/method_name have all been
    deprecated in favor of the 1.9 standard kernel/__method__ and
    kernel/__callee__.
  * Console::Application is deprecated and is no longer an alias for
    Console::Command.
  * More's classinherit.rb has been removed, and classmethods.rb will be
    too in  another version or two. You should transition all uses of
    these to core/module/class_extension.rb.


## 1.3.1 / 2006-04-17

Changes:

* Deprecations

  * Deprecated `String#to_arr`.

* General Enhancements

  * Slightly adjusted `String#to_a`.


## 1.3.0 / 2006-04-05

Changes:

* Additions

  * Ported parts of Nitro's Glue library to Facets.
    * more/aspects.rb
    * core/module/on_included.rb
    * core/module/expirable.rb
    * core/enumerable/accumulate.rb
  * Added xoxo.rb, json.rb and rtals.rb.

* General Enhancements

  * Repaired missing data files for units.rb.
  * Moved cattr methods from module/ to class/.
  * The mattr methods are in limbo at the moment (they were aliases for cattr).


## 1.2.1 / 2006-03-29

Changes:

* Renamed Features

  * `Kernel#meta` has been renamed to `Kernel#instance`.


## 1.2.0 / 2006-03-24

Changes:

* Additions

  * Add zimba.tm's `String#modulize`, `pathize` and `methodize`.
  * Add some Gem methods, self/active?, self/gemspec, self/gempath.


## 1.0.3 / 2006-02-10

Changes:

* Additions

  * Added _why's `Array#modulo`.

* General Enhancements

  * Last ditch attempt to keep Facets and Calibre as one project.


## 1.0.0 / 2005-12-04

Okay. Now we've finally hit our 1.0.0 relase. Yea! Does it desrve 1.0 at this point?
Ah, well close enough. Mainly there won't be anymore silly development names ;)

Changes:

* General Enhancements

  * Sped up string#similarity.
  * By popular protest deprecated usage of "AClass.use Facets, :amethod".
  * Created nicer layout of facets/support, /group, /english (one day /method).
  * Odd sets of facets have been move to facets/group/, eg. facets/group/inflect.
  * All is now well preped for a Rolls release should that ever come about.


