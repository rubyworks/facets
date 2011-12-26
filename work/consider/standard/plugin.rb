#! /usr/local/bin/ruby

#  Copyright (c) 2006-2007 Frédéric Senault.  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of Frédéric Senault or any contributors may be
#    used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

class Plugin
  class << self
    include Enumerable
    attr_accessor :plugin_file_name, :plugin_file_mtime, :plugin_loaded_files
    attr_reader :plugin_sub_classes, :plugin_objects
    def purge_sub_classes!
      @plugin_objects = nil
      @plugin_loaded_files = nil
      @plugin_file_name = nil
      @plugin_file_mtime = nil
      @plugin_sub_classes.each do |c|
        Object.send(:remove_const, c.to_s)
      end
      @plugin_sub_classes = nil
    end
    def reload!
      purge_sub_classes!
      self.load!
    end
    def reload
      if(@plugin_sub_classes) then
        @plugin_sub_classes.each do |c|
          if(File.mtime(c.plugin_file_name) != c.plugin_file_mtime) then
            @plugin_objects.delete(@plugin_objects.find { |o| o.instance_of? c })
            @plugin_sub_classes.delete(c)
            @plugin_loaded_files.delete(c.plugin_file_name)
            Object.send(:remove_const, c.to_s)
          end
        end
      end
      self.load!
    end
    def load!
      @plugin_create_objects = true if(@plugin_create_objects.nil?)
      @plugin_load_glob ||= File.dirname(__FILE__) + '/' +
        self.to_s.downcase + (self.to_s =~ /s$/i ? '' : 's') +
        '/*.rb'
      @plugin_loaded_files ||= []
      Dir.glob(@plugin_load_glob).each do |f|
        unless(@plugin_loaded_files.include? f) then
          @plugin_file_name = f
          @plugin_file_mtime = File.mtime(f)
          @plugin_loaded_files << f
          begin
            load f
          rescue Exception => e
            raise e unless(@plugin_ignore_errors)
          end
        end
      end
      @plugin_sub_classes ||= []
      @plugin_objects ||= []
      if(@plugin_new_sub_classes) then
        @plugin_new_sub_classes.each do |c|
          begin
            c.plugin_validate!
            @plugin_sub_classes << c
            if(@plugin_create_objects) then
              o = c.new()
              @plugin_objects << o
            end
          rescue Exception => e
            raise e unless(@plugin_ignore_errors)
          end
        end
        @plugin_new_sub_classes.clear
      end
      @plugin_sub_classes.sort!
      if(@plugin_create_objects) then
        @plugin_objects.sort! { |a, b| a.class <=> b.class }
      end
    end
    def each
      @plugin_autoload = true unless(@plugin_autoload)
      reload if(@plugin_autoload)
      @plugin_objects.each do |o|
        yield o
      end
    end
    def <=>(other)
      order <=> other.order
    end

    def plugin_validate!
      if(@plugin_implements) then
        r = (@plugin_implements - self.instance_methods.collect { |mn| mn.to_sym })
        if(r.length > 0) then
          raise "Load error in #{superclass.plugin_file_name} : " \
                "#{self.to_s} must implement #{r.join(', ')}."
        end
      end
    end
    def plugin_must_implement(*methods)
      @plugin_implements ||= []
      methods.flatten.each { |mn| @plugin_implements << mn.to_sym }
    end
    def plugin_load_glob(p)
      if(p[0,1] != '/') then
        p = File.dirname(__FILE__) + '/' + p
      end
      @plugin_load_glob = p
    end
    def plugin_ignore_errors(v)
      @plugin_ignore_errors = v
    end
    def plugin_create_objects(v)
      @plugin_create_objects = v
    end
    def plugin_autoload(v)
      @plugin_autoload = v
    end
    def inherited(c)
      @plugin_new_sub_classes ||= [] unless(@plugin_new_sub_classes)
      @plugin_new_sub_classes << c
      if(@plugin_implements) then
        c.plugin_must_implement(@plugin_implements)
        c.plugin_file_name = @plugin_file_name || File.dirname(__FILE__)
        c.plugin_file_mtime = @plugin_file_mtime || File.mtime(__FILE__)
      end
    end
    def order
      999
    end
  end
end
