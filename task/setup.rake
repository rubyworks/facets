
def load_setup
  begin
    require 'setup'
    $setup_installed = true
  rescue LoadError
    $setup_installed = false
    puts "NOTP"
  end
end

private :load_setup

desc "install to ruby site location"
task :install do
  load_setup
  
  if $setup_installed
    sh "setup.rb all"
  else
    puts "Requires stand-alone Setup.rb."
    puts "See http://setup.rubyforge.org"
    puts "or 'gem install setup'."
  end
end

desc "uninstall from ruby site location"
task :uninstall do
  load_setup

  if $setup_installed
    sh "setup.rb uninstall"
  else
    puts "Requires stand-alone Setup.rb."
    puts "See http://setup.rubyforge.org"
    puts "or 'gem install setup'."
  end
end
