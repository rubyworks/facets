# As suggested by Roger Pack this file is a simple convenience
# for loading a limited set of *essential* core extensions. By
# *essential* we mean, more or less, the extensions we think
# ought to be in Ruby proper anyway.
#
# NOTE: This is very much a work in progress! Please feel frre to 
#   suggest which extensions you think belong here.

require_relative 'functor'

### Kernel
require_relative 'kernel/blank'
#require_relative 'kernel/deep_copy'
#require_relative 'kernel/deep_dup'
require_relative 'kernel/false'
require_relative 'kernel/true'

### Object
require_relative 'object/itself'

### Array
require_relative 'array/delete_values'
require_relative 'array/reject_values'
require_relative 'array/uniq_by'

### Binding
require_relative 'binding/self'

### Dir
require_relative 'dir/ascend'
require_relative 'dir/descend'
require_relative 'dir/lookup'

### Enumerable
require_relative 'enumerable/cluster'
require_relative 'enumerable/graph'
require_relative 'enumerable/value_by'

### File
require_relative 'file/write'

### Hash
require_relative 'hash/autonew'
require_relative 'hash/compact'
#require_relative 'hash/data'
require_relative 'hash/delete_values'
require_relative 'hash/except'
require_relative 'hash/rekey'
require_relative 'hash/revalue'
require_relative 'hash/slice'

### Proc
#require_relative 'proc/wrap'

### Regexp
#require_relative 'regexp/to_proc'

### String
require_relative 'string/indent'
require_relative 'string/index_all'
require_relative 'string/mscan'
require_relative 'string/trim'
require_relative 'string/unindent'
#require_realtive 'string/word_wrap'

