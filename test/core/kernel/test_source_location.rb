covers 'facets/kernel/source_location'

tests Kernel do

  omit :source_location => "lemon seems to intefer will call stack" do
    file, line, meth = source_location_example
    file.assert == __FILE__
    line.assert == 13
    meth.assert == :source_location_example
  end

  def source_location_example
    source_location
  end

end
