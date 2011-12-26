## THIS IS NOT THUROUGH ENOUGH
## PROBABY SHOULD MAKE SPECIAL SUBCLASSES
## OF HASH TO HANDLE THIS CONCEPT.
#
# IMPORTANT TODO!!!!

#

class Hash

  attr_accessor :fallback

  # Define a fallback object for #fetch and #[].
  #
  #   f = Hash[:b=>2]
  #   h = Hash[:a=>1].having_aquisition(f)
  #   h[:b] => 2

  def having_aquisition(fallback)

    @fallback = fallback

    unless @fallsback

      def self.[](key)
        begin
          return @fallback[key] if @fallback and not key?(key)
        rescue
        end
        val = super
p val
        val.fallback(self) if Hash == val
        val
      end

      def self.fetch(key, *args, &blk)
        begin
          return @fallback.fetch(key, *args, &blk) if @fallback and not key?(key)
        rescue
        end
        val = super
        val.fallback(self) if Hash == val
        val
      end

      @fallsback = true
    end

    self
  end

  # Define a fallback object for #fetch and #[].
  #
  #   f = Hash[:b=>2]
  #   h = Hash[:a=>1].having_fallback(f)
  #   h[:b] => 2

  def having_fallback(parent=nil)
    @fallback = parent
    unless @fallsback
      def self.[](key)
        return @fallback[key] if @fallback and not key?(key) rescue super
        super
      end

      def self.fetch(key, *args, &blk)
        return @fallback.fetch(key, *args, &blk) if @fallback and not key?(key) rescue super
        super
      end
      @fallsback = true
    end
    self
  end

end
