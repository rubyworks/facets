# RELEASE HISTORY

## 2.7.1 / 2009-11-05

* 1 Major Enhancements

    * Hash#count counts only values

* 5 Minor Enhancements

    * improved 1.9 compatibility for BlankSlate
    * improved 1.9 compatibility for BlankSlate
    * improved 1.9 compatibility for BasicObject
    * 1.9 has no continuation after all
    * Enumerable#count can take multiple items

* 12 Bug Fixes

    * coroutine block args cannot be instance vars
    * defined?(super) is calling super without args? added parens to fix.
    * redo fix for enumerable/mash.rb to work with Ruby 1.9
    * fixed shellwords.rb test
    * String#range_of_line uses #each_line instead of #each
    * fix inheritor.rb to work with 1.9
    * fix inheritor.rb to work with 1.9
    * fix inheritor.rb to work with 1.9
    * Integer#succ becomes Fixnum#succ
    * inheritor.rb, class_extend already extends the module
    * Class#class_extend must extend, not class_eval
    * string/lines.rb, use each_line

* 3 Admin Enhancements

    * fixed String#lines test and added tests for newlines and cleanlines
    * fixed minor bug in Proc#to_method test
    * restored if clause to #count

* 74 General Enhancements

    * String#titlecase includes apostrophe in words now
    * added String#newlines and String#cleanlines
    * fixed alias in string/start_with.rb
    * created separate requires for string/range_xxx methods and index_all
    * created separate requires for string/range_xxx methods and index_all
    * Fixed typo in instance_vars/InstanceVariables that prevented
      instance_vars.update from working.
      Added 'see also' hints in documentation of Kernel#populate and InstanceVariables#update
    * Module#instance_methods returns an array of symbols in Ruby 1.9. Fixed
      FileList so it didn't mix symbols and strings and cause an error ("comparison
      of Symbol with String failed").
    * Fixed some typos in comments/documentation.
      Minor addition to a test.
    * Added Range#at_rand. Fixed test for String#rand_byte that was failing in Ruby 1.9.
    * Fixed typo in instance_vars/InstanceVariables that prevented
      instance_vars.update from working.
      Added 'see also' hints in documentation of Kernel#populate and InstanceVariables#update
      Signed-off-by: 7rans <transfire@gmail.com>
    * Fixed some typos in comments/documentation.
      Minor addition to a test.
      Signed-off-by: 7rans <transfire@gmail.com>
    * Added Range#at_rand. Fixed test for String#rand_byte that was failing in Ruby 1.9.
      Signed-off-by: 7rans <transfire@gmail.com>
    * finally added String#/ as a means of File.join
    * fixed url
      Signed-off-by: 7rans <transfire@gmail.com>
    * using absolute paths - fixes post pages
    * renamed reap to syckle
    * fixed use of rdoc nodoc tag
    * added linkedlist back to more
    * add a couple of work considerations
    * added plugin_manager.rb (temporary, don't use)
    * turn-off webri doc generation for now
    * update facets.rb
    * removed capsule.rb, now separate gem
    * readded semaphore and memoizer
    * Changed string/camelcase.rb to not redefine camelcase if it has already
      been defined. The Facets version is not compatible with the
      ActiveSupport version (in particular, it doesn't seem to play nicely
      with ActiveScaffold).
    * removed fileable.rb, it was not robust
    * fixed kernel/d.rb (it's actually useful now)
    * minor doc improvements
    * Merge: d3c6a26... 2c325ca...
      trying to fix merge conflict
    * improved Pathname extensions
    * added tentative methods Hash#data
    * removed capsule.rb, has been spun-off as separate project
    * put matcher.rb back in lib
    * updated docs of ioredirect.rb
    * add ioredirect test
    * removed progressbar (use ansi instead)
    * spin-off recorder.rb
    * added String#similarity
    * added Levenshtein edit_distance method
    * readded roman.rb
    * check to see if Continuation exists
    * some minor doc fixes
    * renamed snd reworked Shellwords extensions
    * added erb.rb extensions
    * added hashbuilder.rb
    * fixed two tests
    * improved erb.rb using dynamic modules
    * minor update to reademe
    * added mailing list link to README
    * removed ARGV use from Rakefile and added default task
    * removed lore form Rakefile altogether
    * adjusted test for Kernel#object_hexid
    * looks like id changed after 1.8.6
    * refined Enumerable count tests
    * ah, incorrect test expectation
    * is it some bad encoding?
    * [bug] fix enumerable/mash.rb to work with Ruby 1.9
    * update time tests, is 1.9.1 parsing times right?
    * don't show loadpath when running test unless
    * super must have argument for Ruby 1.9
    * deprecated coroutine.rb (will have separate project) since 1.9 has fibers)
    * Binding#__method__ and #__callee__ will only work with versions
      of Ruby that support the underlying methods, or if the Facets
      versions are already loaded (separately).
    * 1.9 will have continuations after all. if so, may move to core.
    * extended #extend
    * inheritor.rb, complete rewrite. obj param must be archetype not default
    * ioredirect.rb, IO.pipe needs splat
    * doc update to inheritor.rb
    * there was a request to keep ini.rb, so ok at least for the time being
    * deprecate ioredirect.rb, a better implementation is needed if we wish to keep
    * temporary removal of binding tests to see if that effects Hash#count
    * put binding test back, seemed to have no effect
    * temporary isolation of Hash#count test
    * add in kernel tests, most likely cuprits
    * restored all tests


## 2.7.0 / 2009-08-25

* 1 Major Enhancements

    * class_extend now extends the current module automatically

* 2 Bug Fixes

    * fixed use of define? to method_define?
    * fixed Proc#curry to work with define_method

* 64 General Enhancements

    * rearrange project
    * add jekyll site
    * moved reap configs
    * update reap configs
    * improved organization of project
    * okay, put rdoc back into doc/
    * updated documentation and .gitignore
    * merged all Rakefile tasks into main file
    * re-added rdoc README's
    * renamed class_extension to class_extend
    * renamed class_extension to class_extend
    * added custom reap task for generating facets.rb
    * enumerablepass.rb is now called enumargs.rb
    * keep version.rb
    * added test for Enumerable#every
    * further organization of work directory
    * further organization of work directory
    * #__HERE__ now has a string output; the old form is now #source_location.
    * added require_relative per 1.9 and improved #__DIR__
    * update jekyll congif
    * fixed website documention
    * added note to main.rb
    * hook.rb, moved demo from comment to demo file
    * use instance_exec for signals
    * update HISTORY
    * note to self, clean up work files
    * fixed website documention
    * added #memoize alias for improved #once method
    * added meta/sitemap (not sure about this)
    * update to facets.rb
    * udpated facets and rubyforge tasks
    * renamed test_emerablepass to test_enumargs
    * workaround String#chars under 1.9
    * added #to_a to enumargs
    * added symlink for website rdocs
    * update reap task configs
    * fix test_class_extend.rb for extension utilizing module/class
    * bump version to 2.7
    * added posts sysmlink
    * readded coroutine.rb
    * added String#unfold
    * added kernel/equate? to core
    * added kernel/identical.rb
    * added Symbol#thrown? and Exception#raised?
    * made class Exception
    * removed logger.rb
    * update README.rdoc
    * use #__send__ instead of #send in object_send
    * String#unfold rstrips final output
    * temp alias of EnumerbalePass
    * missing require in string/test_unfold.rb
    * better hiding of methods in recorder
    * added link to generated webri
    * reworked Enumerable#filter and #defer. now awesome!
    * fixed enumerable/defer
    * split denumerable into separate library
    * improved all 1.8.7+ checks using method_defined?
    * made Enumerable#count compatible with 1.9 ie. no more count(*item)
    * finishing up touch-ups for 1.9 compatability
    * rmoved RELEASE file. no longer needed for reap
    * adjusted Enumerator namespace
    * prepare for 2.7 release
    * deactivate rcov for now
    * insignifficant update to facets.rb


## 2.6.0 / 2009-07-19

* 1 Minor Enhancements

    * corrected ostruct.rb to test for frozen state on updates

* 134 General Enhancements

    * split enumerable/collect into map_with_index and comapct_map
    * fixed source link in website
    * Merge: ad7e8fa... a917218...
      Merge branch 'master' of gitosis@rubyforge.org:facets
    * fixed String#left_align
    * updated AUTHORS
    * added hook.rb
    * improved Array#to_h for 1.9 using flatten(1)
    * Dictionary#replace can take regular Hash too
    * Changed String#indent to let you indent/outdent with a character other than ' '.
    * Changed String#indent to let you indent/outdent with a character other than ' '.
      Signed-off-by: 7rans <transfire@gmail.com>
    * applied sander's patch to to_hash.rb
    * applied sandor's patch to test task
    * move test_to_hash.rb from more to core
    * added suggestion
    * Doc'd that UnboundMethod#name returns Symbol in 1.9, but String in 1.8
    * fixed conflict between test_name.rb and test_arguments.rb
    * added Hash#group_by_value (thanks to Erik Veenstra)
    * fixed Enumreable#split when reciever is empty array
    * association.rb stores refernce when using #new
    * improvements to website
    * added test for enumerable/split
    * fixed coruption of reciever by Hash#collate (thanks to Tilo Sloboda)
    * changed product to make it compatible to ruby 19, deleted block parameter
    * ruby19 compatability: return symbols instead of strings
    * fixed: Array#to_h, h={} was not initialized
    * fixed test of Module#conflict according ruby19
    * updated product.rb
    * Merge: 20022d2... fa22296...
      removed block from Array#product.rb
    * added module/extend.rb, now can take a block.
    * Merge: cd6fd7d... 7c70691...
      Merge commit 'origin/master'
    * fixed doc on Array#product
    * added Hash#new_with (Pit Capitan)
    * overhauled to_hash.rb, now has multiple methods
    * added tests for Array#to_h vs Array#to_h_* dispatch
      Signed-off-by: trans <transfire@gmail.com>
    * added to_h_auto and fixed return bug
    * added String#file
    * fixed: Hash#dearray_singluar_values
      added: tests for Hash#dearray_singluar_values and Hash#dearray_values
      Signed-off-by: trans <transfire@gmail.com>
    * moved Integer::length from more to core
      Signed-off-by: 7rans <transfire@gmail.com>
    * added Sandor's modifications to to_hash.rb
    * update release files
    * updated #to_h_multi documentation
    * moved Hash#dearray_values to own file
    * created separate test for Hash#dearray_values
    * Fix exception reporting in a rake task
      Signed-off-by: trans <transfire@gmail.com>
    * Cleanup rakefile: make sure that it loads without going through setup task each time
      Signed-off-by: trans <transfire@gmail.com>
    * Fix a failing test
      Signed-off-by: trans <transfire@gmail.com>
    * Add map_detect
      Signed-off-by: 7rans <transfire@gmail.com>
    * documented Integer::length and added test
      Signed-off-by: 7rans <transfire@gmail.com>
    * added credit
      Signed-off-by: 7rans <transfire@gmail.com>
    * touch up to paramix
    * prepare for release of 2.5.2
    * organize old release notes and changelogs
    * more orgranization of changelogs
    * added HISTORY file
    * updated HISTORY file wih all old changelogs
    * added string/uppercase and lowercase
    * update minitar.rb to 0.5.2
    * noted rails versions of some string/*ize methods
    * fixed require in string/lowercase.rb
    * bringing over some string methods from English
    * added more/censor.rb (was textfilter.rb from English)
    * added cliable to more library
    * adjust namespace for Cliable
    * added pry.rb to more libs
    * added some libs for consideration
    * removed that stupid old roll.ini file
    * added Kernel#state method
    * moved ByteOrder into Platform
    * fixed bug in Module#extend arity
    * removed Kernel#__HERE__ as it cannot work
    * removed htmlfiler.rb due to licensing (also cssfilter.rb)
    * update HISTORY
    * moved HISTORY to HISTORY.rdoc
    * temp change to HISTORY
    * temp change to HISTORY.rdoc
    * improved HISTORY layout
    * removed buildable.rb
    * removed kernel/meta, it was too experiemental
    * removed cliable.rb --no need to add if we are scaling back
    * removed rwdelegator.rb --too expiremental
    * moved binding/opvars.rb to core
    * removed prototype.rb and upped to version 2.6.0
    * moved reap/service-configs to configs
    * update HISTORY.rdoc
    * gets confused what self is when you use the resultant proc as a method body
      Signed-off-by: 7rans <transfire@gmail.com>
    * BasicObject takes priority over BlankSlate
    * removed deprecated libraries
    * deprecated 1stclassmethod.rb, now part of core
    * added method! and instance_method! to core
    * moved attr_setter from attr.rb to core
    * updated HISTORY.rdoc in anticipation of next release
    * add elementwise methods to core
    * removed synarray.rb and synchash.rb
    * rdocs to use kilmer templates
    * remove spin-offs
    * class_extend can now take modules as arguments
    * removed heap.rb
    * removed paramix.rb
    * removed crypt.rb
    * removed basex.rb
    * removed lrucache.rb
    * removed consoleutils.rb
    * replaced instantize.rb with instance_function.rb
    * remove test to deprecated libs and few more libs too
    * removed nilstatus.rb and orderedhash.rb
    * removed more/momoize.rb, now in core
    * added extra lib directory
    * moved some libs to extra/
    * removed a few more libs
    * moved attr_validator to own files
    * added flush call to Kernel#ask
    * Kernel#once made memo methods private
    * renamed lore/ to standard/
    * updated class_extension
    * facets.rb is now a generated static listing
    * fixed misspelling of equitable
    * removed infinity.rb and interval.rb (now in Stick project)
    * removed most of the remaining more libs
    * reduced to two directoires
    * broke attr methods up and more
    * added Kernel#extension
    * added ObjectSpace.
    * Enumerable#every now uses the more general #per
    * doc fix in each_word.rb
    * remove Lore README and rdoc task
    * added rake task for building facets.rb
    * 1st class methods are stored in global variables
    * added test for kernel/method.rb
    * touchup to test_deepcopy.rb
    * udpated loadpath
    * deprecated reflection.rb
    * okay. put back a dzoen libraries (at least for now)
    * added back OrderedHash alias to Dictionary for now
    * renamed #state to #object_state


## 2.5.0 / 2008-11-27

* 4 Major Enhancements

    * memoize.rb, bug had cache working at class-level, fixed to work at instance-level
    * finalized deprecation of buildable.rb, bytes.rb and times.rb
    * Added Brian Candler's Enumerator::Filter
    * deprecated uploadutils.rb & renamed cachedelegator to memoizer

* 48 General Enhancements

    * switched to git as of 2.4.4
    * aliased Comparable#cap to at_most and separated bound methods into files
    * fixed outdent test and demo in instance_variables.rb
    * deactivated reap test services temporarily
    * updated AUTHORS and README
    * add string/outdent.rb file
    * added lazyenum.rb to work/consider
    * deprecated annotations.rb --use Anise project instead
    * updated all CREDIT: comments elminating any indent
    * binding/caller.rb, fixed require for callstack.rb
    * fixed some credits
    * minor touch up to a few tests
    * moved Hash#symolize_keys to core and removed tagiter.rb
    * renamed DictionaryMatcher to just Matcher
    * improved docs for Hash#rekey
    * removed tests of deprecated libraries
    * removed more/chain.rb; it was expiremental
    * fixed missing require in string/tabto and minor doc adjustments
    * consoleutils.rb and ziputils.rb, added deprecation warning
    * removed some old work material
    * uploadutils.rb, added deprecation warning
    * added test for filter.rb
    * Fixed some bugs with Time#ago/Time#hence not changing years correctly when you changed months.
      (For example, Time.utc(2008, 1, 1).ago(12, :months) incorrectly returned 2009-01-01 instead of 2007-01-01.)
      Added a bunch of tests for Time#ago/Time#hence.
      Changed Time#ago/Time#hence to still work if passed negative number.
    * update authors
    * Merge: 805a1e7... 6713f9e...
      Merge branch 'master' of gitosis@rubyforge.org:facets
    * adjusted docs for eventhook.rb
    * collected notes into doc/guide/notes.rd
    * removed lingering .svn directories
    * deprecated eventhook.rb
    * updated reap service configs
    * moved reap service configs
    * added work/suggestions.txt
    * added sparse_array.rb (was old harray.rb)
    * pathlist, minor spacing adjusment
    * update RELEASE
    * closing in on 2.5 release
    * remove empty config file
    * added stash.rb to more library
    * rewrote duration class (as used in RichUnits)
    * old duration is in work/deprecated for now
    * removed multiplers.rb from deprecation list
    * removed RichUnits namespace from Duration class
    * one last edit of the RELEASE file
    * separated hash update operator tests
    * fixed namespace issure with filter.rb
    * time/hence.rb, added extra precaution to activesupport clause
    * added MANIFEST to .gitignore
    * updated README

