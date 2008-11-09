
  require 'benchmark'
  #require 'pathname'
  require 'mega/pathname'

  $f1 = "a/b/c"
  $f2 = "d/e/f"

  $p1 = Pathname.new($f1)
  $p2 = Pathname.new($f2)

  def file_join
    File.join( $f1 , $f2 )
  end

  def path_join
    $p1 + $p2
  end

  n = 50000
  Benchmark.bm(7) do |x|
    x.report("path-join") { n.times do ; path_join ; end }
    x.report("file-join") { n.times do ; file_join ; end }
  end
