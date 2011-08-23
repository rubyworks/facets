class Dir

  # Is a path parental to another?
  #
  #   Dir.parent?('parent', 'parent/child')  #=> true
  #
  # TODO: Needs improvement.
  #
  # TODO: Instance version?

  def self.parent?(parent_path, child_path)
    %r|^#{Regexp.escape(parent_path)}| =~ child_path ? true : false
  end

end

