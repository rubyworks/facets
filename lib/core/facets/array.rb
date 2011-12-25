require 'facets/kernel/require_relative'

require_relative 'array/after.rb'
require_relative 'array/before.rb'
require_relative 'array/collapse.rb'
require_relative 'array/collisions.rb'
require_relative 'array/combination.rb'
require_relative 'array/commonality.rb'
require_relative 'array/conjoin.rb'
require_relative 'array/contains.rb'
require_relative 'array/delete.rb'
require_relative 'array/delete_unless.rb'
require_relative 'array/delete_values.rb'
require_relative 'array/divide.rb'
require_relative 'array/duplicates.rb'
require_relative 'array/each_pair.rb'
require_relative 'array/each_value.rb'
require_relative 'array/entropy.rb'
require_relative 'array/extract_options.rb'
require_relative 'array/from.rb'
require_relative 'array/index.rb'
require_relative 'array/indexable.rb'
#require_relative 'array/median.rb'             # uncommon
require_relative 'array/merge.rb'
require_relative 'array/mode.rb'
require_relative 'array/nonuniq.rb'
require_relative 'array/not_empty.rb'
require_relative 'array/only.rb'
require_relative 'array/pad.rb'
require_relative 'array/peek.rb'
#require_relative 'array/percentile.rb'         # uncommon
require_relative 'array/permutation.rb'
require_relative 'array/poke.rb'
require_relative 'array/probability.rb'
require_relative 'array/product.rb'
require_relative 'array/pull.rb'
require_relative 'array/occurent.rb'
#require_relative 'array/op_pow.rb'             # uncommon
require_relative 'array/recurse.rb'
require_relative 'array/recursively.rb'
require_relative 'array/rotate.rb'
require_relative 'array/select.rb'
require_relative 'array/splice.rb'
require_relative 'array/split.rb'
require_relative 'array/store.rb'
require_relative 'array/thru.rb'
require_relative 'array/traverse.rb'
require_relative 'array/uniq_by.rb'




#folder = __FILE__.chomp('.rb')

#target = File.basename(folder)

#loader = \
#  if RUBY_VERSION < '1.9'
#    lambda{ |file| require File.join(folder, file) }
#  else
#    lambda{ |file| require_relative File.join(target, file) }
#  end

#files.each do |file|
#  next unless file.end_with?('.rb')
#  loader.call(file)
#end

