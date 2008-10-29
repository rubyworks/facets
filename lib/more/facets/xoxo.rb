# = XOXO
#
# XOXO is a Ruby XOXO parser and generator. It provides
# a Ruby API similar to Marshal and YAML (though more
# specific) to load and dump XOXO[http://microformats.org/wiki/xoxo],
# an simple, open outline format written in standard XHTML and
# suitable for embedding in (X)HTML, Atom, RSS, and arbitrary XML.
#
# == Author
#
# * Christian Neukirchen
#
# == Thanks
#
# Special thanks go to Christian Neukirchen for xoxo.rb.
#   http://chneukirchen.org/repos/xoxo-rb/.
#
# == Copyright
#
# Copyright (C) 2006 Christian Neukirchen
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'rexml/parsers/pullparser'

# = XOXO
#
# XOXO is a Ruby XOXO parser and generator. It provides
# a Ruby API similar to Marshal and YAML (though more
# specific) to load and dump XOXO[http://microformats.org/wiki/xoxo],
# an simple, open outline format written in standard XHTML and
# suitable for embedding in (X)HTML, Atom, RSS, and arbitrary XML.
#
module XOXO

  # xoxo.rb version number
  #VERSION = "0.1"

  # Load and return a XOXO structure from the String, IO or StringIO or _xoxo_.
  #
  def self.load(xoxo)
    structs = Parser.new(xoxo).parse.structs
    while structs.kind_of?(Array) && structs.size == 1
      structs = structs.first
    end
    structs
  end

  # Return a XOXO string corresponding to the Ruby object +struct+,
  # translated to the following rules:
  #
  # * Arrays become ordered lists <tt><ol></tt>.
  # * Hashes become definition lists <tt><dl></tt>, keys are
  #   stringified with +to_s+.
  # * Everything else becomes stringified with +to_s+ and wrapped in
  #   appropriate list elements (<tt><li></tt> or <tt><dt></tt>/<tt><dd></tt>).
  #
  # Additionally, you can pass these options on the _options_ hash:
  # <tt>:html_wrap</tt> => +true+:: Wrap the XOXO with a basic XHTML 1.0
  #                                 Transitional header.
  # <tt>:css</tt> => _css_::        Reference _css_ as stylesheet for the
  #                                 wrapped XOXO document.
  #
  def self.dump(struct, options={})
    struct = [struct]  unless struct.kind_of? Array

    if options[:html_wrap]
      result = <<EOF.strip
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN
http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head profile=""><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
EOF
      if options[:css]
        result << %Q[<style type="text/css" >@import "#{options[:css]}";</style>]
      end

      result << "</head><body>" << make_xoxo(struct, 'xoxo') << "</body></html>"
    else
      result = make_xoxo(struct, 'xoxo')
    end

    result
  end

  private

  def self.make_xoxo(struct, class_name=nil)
    s = ''
    case struct
    when Array
      if class_name
        s << %Q[<ol class="#{class_name}">]
      else
        s << "<ol>"
      end
      struct.each { |item|
        s << "<li>" << make_xoxo(item) << "</li>"
      }
      s << "</ol>"

    when Hash
      d = struct.dup
      if d.has_key? 'url'
        s << '<a href="' << d['url'].to_s << '" '
        text = d.fetch('text') { d.fetch('title', d['url']) }
        %w[title rel type].each { |tag|
          if d.has_key? tag
            s << tag.to_s << '="' << make_xoxo(d.delete(tag)) << '" '
          end
        }
        s << '>' << make_xoxo(text) << '</a>'
        d.delete 'text'
        d.delete 'url'
      end

      unless d.empty?
        s << "<dl>"
        d.each { |key, value|
          s << "<dt>" << key.to_s << "</dt><dd>" << make_xoxo(value) << "</dd>"
        }
        s << "</dl>"
      end

    when String
      s << struct

    else
      s << struct.to_s          # too gentle?
    end

    s
  end
end

class XOXO::Parser              # :nodoc:
  CONTAINER_TAGS = %w{dl ol ul}

  attr_reader :structs

  def initialize(xoxo)
    @parser = REXML::Parsers::PullParser.new(xoxo)

    @textstack = ['']
    @xostack = []
    @structs = []
    @tags = []
  end

  def parse
    while @parser.has_next?
      res = @parser.pull

      if res.start_element?
        @tags << res[0]

        case res[0]
        when "a"
          attrs = normalize_attrs res[1]
          attrs['url'] = attrs['href']
          attrs.delete 'href'
          push attrs
          @textstack << ''

        when "dl"
          push({})

        when "ol", "ul"
          push []

        when "li", "dt", "dd"
          @textstack << ''

        end
      elsif res.end_element?
        @tags.pop

        case res[0]
        when "a"
          val = @textstack.pop
          unless val.empty?
            val = ''  if @xostack.last['title'] == val
            val = ''  if @xostack.last['url'] == val
            @xostack.last['text'] = val  unless val.empty?
          end
          @xostack.pop

        when "dl", "ol", "ul"
          @xostack.pop

        when "li"
          val = @textstack.pop
          while @structs.last != @xostack.last
            val = @structs.pop
            @xostack.last << val
          end
          @xostack.last << val  if val.kind_of? String

        when "dt"
          # skip

        when "dd"
          val = @textstack.pop
          key = @textstack.pop

          val = @structs.pop  if @structs.last != @xostack.last
          @xostack.last[key] = val

        end
      elsif res.text?
        unless @tags.empty? || CONTAINER_TAGS.include?(@tags.last)
          @textstack.last << res[0]
        end
      end
    end

    self
  end

  private

  def normalize_attrs(attrs)
    attrs.keys.find_all { |k, v| k != k.downcase }.each { |k, v|
      v = v.downcase  if k == "rel" || k == "type"
      attrs.delete k
      attrs[k.downcase] = v
    }
    attrs
  end

  def push(struct)
    if struct == {} && @structs.last.kind_of?(Hash) &&
        @structs.last.has_key?('url') &&
        @structs.last != @xostack.last
      # put back the <a>-made one for extra def's
      @xostack << @structs.last
    else
      @structs << struct
      @xostack << @structs.last
    end
  end
end


class Object

  # Dump object as XOXO.

  def to_xoxo(*args)
    XOXO.dump(self,*args)
  end

end
