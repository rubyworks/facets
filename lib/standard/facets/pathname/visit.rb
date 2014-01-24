class Pathname

  # Recursively visit a directory located by its path, yielding each resource
  # as its full matching pathname object. If called on a file, yield the file.
  #
  # call-seq:
  #   visit => yield each file
  #   visit(all: true) => yield visited directories as well
  #   visit(hidden: true) => yield hidden files and directories as well
  #
  # Examples
  #
  #     # Locate any file but *.haml within app/**/*
  #     Pathname.new("app").visit do |f|
  #       next unless f.to_s =~ /\.haml$/
  #       f
  #     end 
  #
  # TODO: Use #map instead of #each?
  # 
  # CREDIT: Jean-Denis Vauguet

  def visit(options = {:all => false, :hidden => false})
    if self.directory?
      children.each do |entry|
        next if entry.basename.to_s[0] == "." && !options[:hidden]
        yield(entry) unless entry.directory? && !options[:all]
        ##entry.visit(:all => options[:all]) { |sub_entry| yield sub_entry } if entry.directory?
        entry.visit(:all => options[:all], :hidden => options[:hidden]) do |sub_entry|
          yield(sub_entry)
        end if entry.directory?
      end
    else
      yield self
    end
  end

end
