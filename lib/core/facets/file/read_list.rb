class File

  # Reads in a file, removes blank lines and removes lines starting
  # with '#' and then returns an array of all the remaining lines.
  #
  # Thr remark indicator can be overridden via the +:omit:+ option, which
  # can be a regualar expression or a string that is match against the
  # start of a line.
  #
  # CREDIT: Trans

  def self.read_list(filepath, options={})
    chomp = options[:chomp]
    omit  = case options[:omit]
            when Regexp
              omit
            when nil
              /^\s*\#/
            else
              /^\s*#{Regexp.escape(omit)}/
            end

    list = []
    readlines(filepath).each do |line|
      line = line.strip.chomp(chomp)
      next if line.empty?
      next if omit === line
      list << line
    end
    list
  end

end

