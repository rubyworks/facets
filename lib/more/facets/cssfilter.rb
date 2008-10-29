# = CSS Filter
#
# The CssFilter class will clean up a cascading style sheet.
# It can be used to remove whitespace and most importantly
# remove urls.
#
# == Authors
#
# * Trans
#
# == Todo
#
# * Allow urls to be specified per attribute type.
#
# == Copying
#
#   Copyright (c) 2007 7rans

require 'facets/uri'

# = CSS Filter
#
# The CssFilter class will clean up a cascading style sheet.
# It can be used to remove whitespace and most importantly
# remove urls.
#
class CssFilter

  # should we remove comments? (true, false)
  attr_accessor :strip_comments

  # should we remove urls? (true, false)
  attr_accessor :strip_urls

  # url schemes which will be allowed (http, ftp, mailto)
  attr_accessor :allowed_scheme

  # alias for allowed_scheme
  alias_method :allowed_protocols, :allowed_scheme
  alias_method :allowed_protocols=, :allowed_scheme=

  # url hosts which will be allowed.
  attr_accessor :allowed_hosts

  # urls which will be allowed. (NOT YET USED)
  attr_accessor :allowed_urls

  # substitue urls  (NOT YET USED)
  attr_accessor :substitute_urls

  # remove blank lines.
  attr_accessor :strip_whitespace

  # remove blank lines.
  attr_accessor :strip_blanklines

  # Complete parse and rewrite of CSS document.
  # This does a complete "cleaning" but note that
  # is not yet a perfect parser.
  attr_accessor :rewrite

  # CssFilter option defaults.

  DEFAULT = {
    'strip_comments' => true,
    'strip_urls' => true,
    'allowed_urls' => [],
    'allowed_hosts' => [],
    'allowed_scheme' => [],
    'strip_whitespace' => false,
    'strip_blanklines' => true,
    'rewrite' => false,
    'substitute_urls' => {}
  }

  #

  def initialize(options=nil)
    if options
      h = DEFAULT.dup
      options.each do |k,v|
        h[k.to_s] = v
      end
      options = h
    else
      options = DEFAULT.dup
    end

    options.each{ |k,v| send("#{k}=",v) }
  end

  #

  def accept_host(host)
    @hosts << host
  end

  #

  def filter(css)
    css = remove_comments(css)    if strip_comments
    css = remove_urls(css)        if strip_urls

    css = remove_nullvalues(css)

    css = remove_whitespace(css)  if strip_whitespace
    css = remove_blanklines(css)  if strip_blanklines

    css = parse(css).to_css       if rewrite
    css
  end

  #

  def remove_comments(data)
    data.gsub(/\/\*(.8?)\*\//,'')
  end

  # TODO: allowed_urls

  def remove_urls(data)
    urls = data.scan(/url\((.*?)\)/).flatten
    uris = urls.collect{ |u| URI.extract(u) }.flatten
    uris.each do |u|
      uri = URI.parse(u)
      unless allowed_hosts.include?(uri.host) or
             allowed_scheme.include?(uri.scheme)
        data.sub!(u.to_s, '')
      end
    end
    data.gsub(/url\(\s*\)/, '')
  end

  #

  def remove_whitespace(data)
    data = data.gsub(/^\s*/,'')
    data = data.gsub(/\s*$/,'')
  end

  #

  def remove_blanklines(data)
    data = data.gsub(/^\s*\n/,'')
  end

  #

  def remove_nullvalues(data);
    data = data.gsub(/\w+[:](\s+)[;]/,'')
  end

  # Breaks a css document up into a hash. This can be used
  # completely rewritting the css.
  #
  # TODO: Not complete, does not work with "@xxx foo;" for example.

  def parse(css)
    tree = CssTree.new
    entries = css.scan(/^(.*?)\{(.*?)\}/m)
    entries.each do |ref, props|
      tree[ref.strip] ||= {}
      props = clean_properties(props)
      props = props.scan(/(.*?)[:](.*?)([;]|\s*\Z)/)
      props.each do |(key,val)|
        tree[ref.strip][key.strip] = clean_value(val)
      end
    end
    return tree
  end

  # Takes a css entry and ensures it is valid (as best it can).
  # It will fix trival mistakes, and raise an error when it is
  # beyond repair.
  #
  # TODO: So far this does absolutely nothing!

  def clean_properties(atts)
    atts
  end

  #

  def clean_value(val)
    val = val.strip

    if urls
      uris = URI.extract(val)
      uris.each do |u|
        val.sub!(u.to_s, urls)
      end
    end

    return val
  end

end


# CSS parse tree. This is for a "deep filtering".

class CssTree < Hash

  def initialize(options=nil)
    @options = options || {}
    super()
  end

  # Re-output the CSS, all tidy ;)

  def to_css
    css = ""
    each do |selector, entries|
      css << "#{selector}{"
      entries.each do |key, value|
        css << "#{key}:#{value};"
      end
      css << "}\n"
    end
    return css
  end

end



if $0 == __FILE__

  require 'yaml'

  css = <<-END
    * {
      margin: 0;
      height: 0;
    }

    body {
      margin: 0;
      height: 0;
      background: url(http://xzy.org);
    }

    h1 {
      trythis: url(http://here.org/fun.js);
      font-size: 12pt;
    }
  END

  cssfilter = Blow::CssFilter.new(:allowed_hosts=>["here.org"])
  csstree   = cssfilter.filter(css)
  #y csstree
  puts csstree

end
