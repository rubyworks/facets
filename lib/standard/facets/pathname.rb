require 'pathname'

require 'facets/pathname/home'
require 'facets/pathname/null'
require 'facets/pathname/op_div'
require 'facets/pathname/op_fetch'
require 'facets/pathname/root'
require 'facets/pathname/work'

require 'facets/pathname/empty'
require 'facets/pathname/exists'
require 'facets/pathname/glob'
require 'facets/pathname/outofdate'
require 'facets/pathname/readline'
require 'facets/pathname/rootname'
require 'facets/pathname/safe'
require 'facets/pathname/split_root'
require 'facets/pathname/to_str'
require 'facets/pathname/uptodate'
require 'facets/pathname/visit'

require 'facets/pathname/to_path'


##   # Already included in 1.8.4+ version of Ruby (except for inclusion flag)
##   if not instance_methods.include?(:ascend)
##
##     # Calls the _block_ for every successive parent directory of the
##     # directory path until the root (absolute path) or +.+ (relative path)
##     # is reached.
##     def ascend(inclusive=false,&block) # :yield:
##       cur_dir = self
##       yield( cur_dir.cleanpath ) if inclusive
##       until cur_dir.root? or cur_dir == Pathname.new(".")
##         cur_dir = cur_dir.parent
##         yield cur_dir
##       end
##     end
##
##   end
##
##   # Already included in 1.8.4+ version of Ruby
##   if ! instance_methods.include?(:descend)
##
##     # Calls the _block_ for every successive subdirectory of the
##     # directory path from the root (absolute path) until +.+
##     # (relative path) is reached.
##     def descend()
##       @path.scan(%r{[^/]*/?})[0...-1].inject('') do |path, dir|
##         yield Pathname.new(path << dir)
##       path
##       end
##     end
##
##   end

