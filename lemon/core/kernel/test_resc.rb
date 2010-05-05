Covers 'facets/kernel/resc'

Case Kernel do

  Unit :resc do
    resc("'jfiw0[]4").assert == Regexp.escape("'jfiw0[]4")
    resc("/////").assert == Regexp.escape("/////")
  end

end

