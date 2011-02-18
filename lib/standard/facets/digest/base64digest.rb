require 'digest'

module Digest

  module Instance

    # For Ruby < 1.9.2
   
    unless instance_methods.include? :base64digest

      # From Ruby 1.9.2 source
      def base64digest(str = nil)
        [str ? digest(str) : digest].pack('m0')
      end

    end

    unless instance_methods.include? :base64digest!

      # From Ruby 1.9.2 source
      def base64digest!
        [digest!].pack('m0')
      end

    end

  end

  class Class

    # For Ruby < 1.9.2   

    unless methods.include? :base64digest

      # From Ruby 1.9.2 source
      def self.base64digest(str, *args)
        [self.digest(str, *args)].pack('m0') 
      end

    end

  end

end

