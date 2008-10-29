#
# ini.rb - read and write ini files
#
# Copyright (C) 2007 Jeena Paradies
# License: GPL
# Author: Jeena Paradies (info@jeenaparadies.net)
#
# == Overview
#
# This file provides a read-wite handling for ini files.
# The data of a ini file is represented by a object which
# is populated with strings.

class Ini
  
  # Class with methods to read from and write into ini files.
  #
  # A ini file is a text file in a specific format,
  # it may include several fields which are sparated by
  # field headlines which are enclosured by "[]".
  # Each field may include several key-value pairs.
  #
  # Each key-value pair is represented by one line and
  # the value is sparated from the key by a "=".
  #
  # == Examples
  #
  # === Example ini file
  #
  #   # this is the first comment which will be saved in the comment attribute
  #   mail=info@example.com
  #   domain=example.com # this is a comment which will not be saved
  #   [database]
  #   db=example
  #   user=john
  #   passwd=very-secure
  #   host=localhost
  #   # this is another comment
  #   [filepaths]
  #   tmp=/tmp/example
  #   lib=/home/john/projects/example/lib
  #   htdocs=/home/john/projects/example/htdocs
  #   [ texts ]
  #   wellcome=Wellcome on my new website!
  #   Website description = This is only a example. # and another comment
  #
  # === Example object
  #
  #   A Ini#comment stores:
  #   "this is the first comment which will be saved in the comment attribute"
  #
  #   A Ini object stores:
  #
  #   {
  #    "mail" => "info@example.com",
  #    "domain" => "example.com",
  #    "database" => {
  #     "db" => "example",
  #     "user" => "john",
  #     "passwd" => "very-secure",
  #     "host" => "localhost"
  #    },
  #    "filepaths" => {
  #     "tmp" => "/tmp/example",
  #     "lib" => "/home/john/projects/example/lib",
  #     "htdocs" => "/home/john/projects/example/htdocs"
  #    }
  #    "texts" => {
  #     "wellcome" => "Wellcome on my new website!",
  #     "Website description" => "This is only a example."
  #    }
  #   }
  #
  # As you can see this module gets rid of all comments, linebreaks
  # and unnecessary spaces at the beginning and the end of each
  # field headline, key or value.
  #
  # === Using the object
  #
  # Using the object is stright forward:
  #
  #   ini = Ini.new("path/settings.ini")
  #   ini["mail"] = "info@example.com"
  #   ini["filepaths"] = { "tmp" => "/tmp/example" }
  #   ini.comment = "This is\na comment"
  #   puts ini["filepaths"]["tmp"]
  #   # => /tmp/example
  #   ini.write()
  # 
  
  #
  # :inihash is a hash which holds all ini data
  # :comment is a string which holds the comments on the top of the file
  #
  attr_accessor :inihash, :comment

  #
  # Creating a new Ini object
  #
  # +path+ is a path to the ini file
  # +load+ if nil restores the data if possible
  #        if true restores the data, if not possible raises an error
  #        if false does not resotre the data
  #
  def initialize(path, load=nil)
    @path = path
    @inihash = {}
    
    if load or ( load.nil? and FileTest.readable_real? @path )
      restore()
    end
  end
  
  #
  # Retrive the ini data for the key +key+
  #
  def [](key)
    @inihash[key]
  end
  
  #
  # Set the ini data for the key +key+
  #
  def []=(key, value)
    raise TypeError, "String expected" unless key.is_a? String
    raise TypeError, "String or Hash expected" unless value.is_a? String or value.is_a? Hash
    
    @inihash[key] = value
  end
  
  #
  # Restores the data from file into the object
  #
  def restore()
    @inihash = Ini.read_from_file(@path)
    @comment = Ini.read_comment_from_file(@path)
  end
  
  #
  # Store data from the object in the file
  #
  def update()
    Ini.write_to_file(@path, @inihash, @comment)
  end

  #
  # Reading data from file
  #
  # +path+ is a path to the ini file
  #
  # returns a hash which represents the data from the file
  #
  def Ini.read_from_file(path)
        
    inihash = {}
    headline = nil
    
    IO.foreach(path) do |line|

      line = line.strip.split(/#/)[0]
      
      # read it only if the line doesn't begin with a "=" and is long enough
      unless line.length < 2 and line[0,1] == "="
        
        # it's a headline if the line begins with a "[" and ends with a "]"
        if line[0,1] == "[" and line[line.length - 1, line.length] == "]"
          
          # get rid of the [] and unnecessary spaces
          headline = line[1, line.length - 2 ].strip
          inihash[headline] = {}
        else
        
          key, value = line.split(/=/, 2)
          
          key = key.strip unless key.nil?
          value = value.strip unless value.nil?
          
          unless headline.nil?
            inihash[headline][key] = value
          else
            inihash[key] = value unless key.nil?
          end
        end        
      end
    end
    
    inihash
  end
  
  #
  # Reading comments from file
  #
  # +path+ is a path to the ini file
  #
  # Returns a string with comments from the beginning of the
  # ini file.
  #
  def Ini.read_comment_from_file(path)
    comment = ""
    
    IO.foreach(path) do |line|
      line.strip!
      break unless line[0,1] == "#" or line == ""
      
      comment << "#{line[1, line.length ].strip}\n"
    end
    
    comment
  end
  
  #
  # Writing a ini hash into a file
  #
  # +path+ is a path to the ini file
  # +inihash+ is a hash representing the ini File. Default is a empty hash.
  # +comment+ is a string with comments which appear on the
  #           top of the file. Each line will get a "#" before.
  #           Default is no comment.
  #
  def Ini.write_to_file(path, inihash={}, comment=nil)
    raise TypeError, "String expected" unless comment.is_a? String or comment.nil?
    
    raise TypeError, "Hash expected" unless inihash.is_a? Hash
    File.open(path, "w") { |file|
      
      unless comment.nil?
        comment.each do |line|
          file << "# #{line}"
        end
      end
      
      file << Ini.to_s(inihash)
    }
  end
  
  #
  # Turn a hash (up to 2 levels deepness) into a ini string
  #
  # +inihash+ is a hash representing the ini File. Default is a empty hash.
  #
  # Returns a string in the ini file format.
  #
  def Ini.to_s(inihash={})
    str = ""
    
    inihash.each do |key, value|

      if value.is_a? Hash
        str << "[#{key.to_s}]\n"
        
        value.each do |under_key, under_value|
          str << "#{under_key.to_s}=#{under_value.to_s unless under_value.nil?}\n"
        end

      else
        str << "#{key.to_s}=#{value.to_s unless value2.nil?}\n"
      end
    end
    
    str
  end
  
end

