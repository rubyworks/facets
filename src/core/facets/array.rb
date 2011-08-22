=begin :erb+40:
<%=
  path = __FILE__.chomp('.rb')
  base = File.basename(path)
  Dir[File.join(path, '*.rb')].map do |lib|
    #require lib # why is this so much slower?
    %Q{require "facets/#{base}/#{File.basename(lib)}"}
  end.sort.join("\n")
%>
=end
require "facets/array/after.rb"
require "facets/array/before.rb"
require "facets/array/collapse.rb"
require "facets/array/collisions.rb"
require "facets/array/combination.rb"
require "facets/array/commonality.rb"
require "facets/array/conjoin.rb"
require "facets/array/contains.rb"
require "facets/array/delete.rb"
require "facets/array/delete_unless.rb"
require "facets/array/delete_values.rb"
require "facets/array/divide.rb"
require "facets/array/duplicates.rb"
require "facets/array/entropy.rb"
require "facets/array/extract_options.rb"
require "facets/array/from.rb"
require "facets/array/index.rb"
require "facets/array/indexable.rb"
require "facets/array/merge.rb"
require "facets/array/mode.rb"
require "facets/array/nonuniq.rb"
require "facets/array/not_empty.rb"
require "facets/array/only.rb"
require "facets/array/pad.rb"
require "facets/array/peek.rb"
require "facets/array/permutation.rb"
require "facets/array/poke.rb"
require "facets/array/probability.rb"
require "facets/array/product.rb"
require "facets/array/pull.rb"
require "facets/array/recurse.rb"
require "facets/array/recursively.rb"
require "facets/array/rotate.rb"
require "facets/array/select.rb"
require "facets/array/splice.rb"
require "facets/array/split.rb"
require "facets/array/store.rb"
require "facets/array/thru.rb"
require "facets/array/traverse.rb"
require "facets/array/uniq_by.rb"
