# = tagiterator.rb
#
# == Copyright (c) 2000 Ⴗnyasu <nyasu@osk.3web.ne.jp>
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#   FOR A PARTICULAR PURPOSE.
#
# == Author(s)
#
# * Ⴗnyasu

# Author::    Ⴗnyasu <nyasu@osk.3web.ne.jp>
# Copyright:: Copyright (c) 2000 Ⴗnyasu
# License::   Ruby License

# = TagIterator (aka Tagiter)
#
# Simple but very useful HTML/XHTML cascading parser.
#
# Quickly iterate through tagged markup documents like HTML and XML.
# TagIterator is great for quick and dirty web scrapping.
#
# == Usage
#
#   # sample html
#   stext = <<-EOF
#   <body> This is a test...
#     <sub> S1 </sub> <sub> S2 </sub>
#     <DL>
#       <DT> A1
#       <DT> A2
#       <DT> A3
#     </DL>
#     <DL>
#       <DT> B1
#       <DT> B2
#       <DT> B3
#     </DL>
#     <NEST>
#       <P ALIGN="R">TOP</P>
#       <NEST>
#         <P>SECOND</P>
#         <OL>
#           <LI>C1
#           <LI>C2
#           <LI>C3
#           <LI>C4
#         </OL>
#       </NEST>
#       <OL>
#         <LI>D1
#         <LI>D2
#         <LI>D3
#         <LI>D4
#       </OL>
#     </NEST>
#   </body>
#   EOF
#
#   a = TagIterator.new(stext)
#   a.first("body") do |y|
#     y.nth("dl",2) do |dl|
#       dl.enumtag("dt") do |t|
#         puts t.text.strip
#       end
#     end
#     y.first("nest") do |n|
#       n.first("p") do |c|
#         print c.text, ' '
#         puts c.attributes.collect{ |k,v| "#{k}=#{v}" }
#       end.next("nest") do |m|
#         m.first("p") do |c|
#           puts c.text
#         end.next("ol") do |o|
#           o.enumtag("li") do |i| puts i.text.strip end
#         end
#       end.next("ol") do |o|
#         o.enumtag("li") do |i| puts i.text.strip end
#       end
#     end
#   end
#   a.each_block("sub") do |y|
#     puts y.text.strip
#   end
#
# _produces_
#
#   B1
#   B2
#   B3
#   TOP align=R
#   SECOND
#   C1
#   C2
#   C3
#   C4
#   D1
#   D2
#   D3
#   D4
#   S1
#   S2
#

class TagIterator

  attr :text
  attr :option, true
  attr :tag
  attr :attributes

  private

  def initialize(text,tag=nil,attributes={})
    raise RuntimeError,"Only String accepted" unless text.is_a?(String)
    @text=text
    @option="pi"
    @tag=tag
    @attributes=attributes
    def @attributes.[](aname)
      super aname.downcase
    end
  end

  def find_element(element,st=0)
    rex=Regexp.new('<(\s|\n)*'+element+'(\s|\n|>)',@option)
    @text.index(rex,st)
  end

  def parse_attribute(attstr)
    k={}; r={}; 
    attstr.scan(/(\w+)=(\S+)/) do |pt| k[ pt[0] ] = pt[1] end
    attstr.scan(/(\w+)="([^"]*)"/) do |pt| k[ pt[0] ] = pt[1] end
    k.each do |key,val| r[key.downcase]=val end
    r
  end

  def find_opentag(tag,st=0)
    s=find_element(tag,st)
    return nil unless s

    r=@text.index('>',s)
    return r+1,@text[s+1..r-1]
  end

  def find_closetag(tag,st,opentag=nil)
    if opentag then
      p=find_element(tag,st)
      q,d = find_opentag(opentag,st)
    else
      p=find_element('/\s*'+tag,st)
      q,d = find_opentag(tag,st)
    end
    p-=1 if p 

    if p and q then if p > q then    # tag nested
      p=find_closetag(tag,find_closetag(tag,q,opentag)+2,opentag)
    end end

    return p
  end

  def find_closeenumtag(tag,st=0)
    rex=Regexp.new('<\s*'+tag,@option)
    s=@text.index(rex,st)
    s-=1 if s
    s
  end
  alias_method :find_openenumtag, :find_opentag

  public

  def nth(tag,n,closetag=nil)
    raise RuntimeError,"nth: number not specified" unless n
    t=0
    e=s=0   # for their scope
    d=nil

    1.upto(n) do |i|
      s,d = find_opentag(tag,t)
      raise RuntimeError,"tag(#{tag}) not found at(#{i})" unless s

      if closetag then
        e=find_closetag(closetag,s,tag)
      else
        e=find_closetag(tag,s)
      end
      e=-1 unless e
      t=@text.index('>',e+1)
      t=@text.length unless t
    end
    yield self.class.new(text[s..e],tag,parse_attribute(d))
    self.class.new(text[t+1..-1])
  end

  def first(tag,*arg) nth(tag,1,*arg) do |f| yield f end end
  alias_method :next, :first

  def each_block(tag,closetag=nil)
    t=0
    s,d =find_opentag(tag)
    raise RuntimeError,"tag(#{tag}) not found" unless s

    while s do
      if closetag then
        e=find_closetag(closetag,s,tag)
      else
        e=find_closetag(tag,s)
      end
      e=-1 unless e
      yield self.class.new(@text[s..e],tag,parse_attribute(d))
      if e>=0 then 
        t=@text.index('>',e+1)
        t=@text.length unless t
        s,d = find_opentag(tag,t)
      else
        s=false
      end
    end
    self.class.new(text[t+1..-1])
  end

  def collect(*arg)
    a=[]
    each_block(*arg) do |tt| a.push tt end
    a
  end

  def enumtag(tag)
    s,d = find_openenumtag(tag)
    while s do
      e=find_closeenumtag(tag,s+1)
      e=-1 unless e
      yield self.class.new(@text[s..e],tag,parse_attribute(d))
      s,d = find_openenumtag(tag,s)
    end
  end

  def enumcollect(tag)
    a=[]
    enumtag(tag) do |t| a.push t end
    a
  end

  def for_this
    yield self
  end

  def get_nth(*arg) r=nil; nth(*arg) do |bl| r=bl end; r; end

  def get_first(*arg) r=nil; first(*arg) do |bl| r=bl end; r; end

  def tagexist?(tag,st=0)
    s=find_element(tag,st)
    if s then true else false end
  end

  def tagnext
    s=@text.index("<")
    return nil unless s
    e=@text.index(">",s)
    return nil unless s
    @text[s..e].scan(/[^<>\s]+/)[0]
  end

  def nth_tailer(tag,n)
    nth(tag,n) do end
  end

end



#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#

=begin testing

require 'test/unit'

class TC_TagIterator < Test::Unit::TestCase

  STEXT = <<-EOS
  <body> This is a test...
    <sub> S1 </sub> <sub> S2 </sub>
    <DL>
      <DT> A1
      <DT> A2
      <DT> A3
    </DL>
    <DL>
      <DT> B1
      <DT> B2
      <DT> B3
    </DL>
    <NEST>
      <P ALIGN="R">TOP</P>
      <NEST>
        <P>SECOND</P>
        <OL>
          <LI>C1
          <LI>C2
          <LI>C3
          <LI>C4
        </OL>
      </NEST>
      <OL>
        <LI>D1
        <LI>D2
        <LI>D3
        <LI>D4
      </OL>
    </NEST>
  </body>
  EOS

  def test_all
    assert_nothing_raised{ @a = TagIterator.new( STEXT ) }
    @f = []
    assert_nothing_raised {
      @a.first("body") do |y|
        y.nth("dl",2) do |dl|
          dl.enumtag("dt") do |t|
            @f << t.text.strip
          end
        end
        y.first("nest") do |n|
          n.first("p") do |c|
            @f << c.text
            @f.concat c.attributes.collect{ |k,v| "#{k}=#{v}" }
          end.next("nest") do |m|
            m.first("p") do |c|
              @f << c.text
            end.next("ol") do |o|
              o.enumtag("li") do |i| @f << i.text.strip end
            end
          end.next("ol") do |o|
            o.enumtag("li") do |i| @f << i.text.strip end
          end
        end
      end
      @a.each_block("sub") do |y|
        @f << y.text.strip
      end
    }
    o = [ "B1", "B2", "B3",
          "TOP", "align=R", "SECOND",
          "C1", "C2", "C3", "C4",
          "D1", "D2", "D3", "D4",
          "S1", "S2" ]
    assert_equal( o, @f )
  end

end

=end
