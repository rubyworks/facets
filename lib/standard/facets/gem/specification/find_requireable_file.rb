module Gem
  class Specification

    # Return full path of requireable file given relative path.
    def find_requireable_file(file)
      root = full_gem_path

      require_paths.each do |lib|
        base = File.join(root, lib, file)
        Gem.suffixes.each do |suf|
          path = "#{base}#{suf}"
          return path if File.file? path
        end
      end

      return nil
    end

  end
end

