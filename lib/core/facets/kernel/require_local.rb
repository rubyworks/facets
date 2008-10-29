module Kernel

  # Require file from same dir as calling script.
  #
  #   require_local 'templib'
  #
  def require_local(fname)
    #fdir = File.expand_path( File.dirname( caller[0] ) )
    fdir = File.dirname( caller[0] )
    require( File.join( fdir, fname ) )
  end

  # Load file from same dir as calling script.
  #
  #   load_local 'templib'
  #
  def load_local(fname, safe=nil)
    #fdir = File.expand_path( File.dirname( caller[0] ) )
    fdir = File.dirname( caller[0] )
    load( File.join( fdir, fname ), safe )
  end

end

