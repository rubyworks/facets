module FileTest

  module_function

  # Does the +parent+ contain the +child+?
  def contains?(child, parent=Dir.pwd)
    parent = File.expand_path(parent)
    child = File.expand_path(child)
    child.sub(parent,'') != child
  end

end
