
ARG = ARGV.dup

class << ARG

  def arguments
    @arguments ||= select{ |e| e !~ /^-/ && e !~ /=/ }
  end

  def options
    @options ||= (
      pms = {}
      select{ |e| /[=]/ =~ e }.each do |e|
        k,v = e.split('=')
        k.sub!(/^[-]{1,2}/,'')
        pms.store(k,v)
      end
      select{ |e| e =~ /^-/ || e !~ /=/ }.each do |k|
        k.sub!(/^[-]{1,2}/,'')
        pms.store(k,true)
      end
      pms
    )
  end

  def flags
    @flags ||= select{ |e| e =~ /^-/ || e !~ /=/ }
  end

  # Have specific flag?

  def flag?(flag)
    flags.include?(flag)
  end

  #

  def [](x)
    case x
    when Integer
      arguments[x]
    else
      options[x.to_s]
    end
  end

end