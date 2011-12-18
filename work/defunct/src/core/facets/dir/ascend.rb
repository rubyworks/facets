class Dir

  # TODO: Make instance method versions ?

  # Ascend a directory path.
  #
  #   a = []
  #
  #   Dir.ascend("/var/log") do |path|
  #     a << path
  #   end
  #
  #   a  #=> ['/var/log', '/var', '/']
  #
  # CREDIT: Daniel Berger, Jeffrey Schwab
  #
  # TODO: make it work with windows too
  # use FileTest.root?

  def self.ascend(dir, inclusive=true, &blk)
    dir = dir.dup
    blk.call(dir) if inclusive
    ri = dir.rindex('/')
    while ri
      dir = dir.slice(0...ri)
      if dir == ""
        blk.call('/') ; break
      end
      blk.call( dir )
      ri = dir.rindex('/')
    end
  end

  # Descend a directory path.
  #
  #   d = []
  #
  #   Dir.descend("/var/log") do |path|
  #     d << path
  #   end
  #
  #   d  #=> ['/', '/var', '/var/log']
  #
  # CREDIT: Daniel Berger, Jeffrey Schwab

  def self.descend(path) #:yield:
    paths = path.split('/')
    paths.size.times do |n|
      pth = File.join(*paths[0..n])
      pth = "/" if pth == ""
      yield(pth)
    end
  end

end

