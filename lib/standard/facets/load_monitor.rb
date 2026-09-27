# @deprecated Monkey-patching require/load globally is dangerous.
#   Scheduled for removal after 2027-09-30.
warn "facets/load_monitor is deprecated. It monkey-patches require/load globally. It will be removed after 2027-09-30.", uplevel: 1
