require 'fileutils'

module FileUtils

  if defined?(Win32Exts)
    Win32Exts |= %w{.exe .com .bat .cmd}
  else
    Win32Exts = %w{.exe .com .bat .cmd}
  end

  # In block form, yields each ((*program*)) within ((*path*)).  In non-block
  # form, returns an array of each ((*program*)) within ((*path*)).  Returns
  # (({nil})) if not found.
  #
  # On the MS Windows platform, it looks for executables ending with .exe,
  # .bat and .com, which you may optionally include in the program name.
  #
  #    FileUtils.whereis("ruby") -> ['/usr/local/bin/ruby','/opt/bin/ruby']
  #
  # CREDIT Daniel J. Berger

  module_function
  def whereis(prog, path=ENV['PATH']) #:yield:
    dirs = []
    path.split(File::PATH_SEPARATOR).each{|dir|
        # Windows checks against specific extensions
        if File::ALT_SEPARATOR
          if prog.include?('.')
              f = File.join(dir,prog)
              if File.executable?(f) && !File.directory?(f)
                if block_given?
                    yield f.gsub(/\//,'\\')
                else
                    dirs << f.gsub(/\//,'\\')
                end
              end
          else
              Win32Exts.find_all{|ext|
                f = File.join(dir,prog+ext)
                if File.executable?(f) && !File.directory?(f)
                    if block_given?
                      yield f.gsub(/\//,'\\')
                    else
                      dirs << f.gsub(/\//,'\\')
                    end
                end
              }
          end
        else
          f = File.join(dir,prog)
          # Avoid /usr/lib/ruby, for example
          if File.executable?(f) && !File.directory?(f)
              if block_given?
                yield f
              else
                dirs << f
              end
          end
        end
    }
    dirs.empty? ? nil : dirs
  end

end
