# @deprecated Use Kernel#functor instead.
#   Scheduled for removal after 2027-09-30.
warn "facets/kernel/tee is deprecated. Use facets/kernel/functor instead. " \
     "It will be removed after 2027-09-30.", uplevel: 1
require 'facets/kernel/functor'
