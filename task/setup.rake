begin
  require 'setup'
  $setup_installed = true  
rescue => LoadError
  $setup_installed = false
puts "NOTP"
end

desc "install to ruby site location"
task "setup:install" do
  if $setup_installed
    sh "setup.rb all"
  else
    puts "Requires stand-alone Setup.rb."
    puts "See http://setup.rubyforge.org"
    puts "or 'gem install setup'."
  end
end

desc "uninstall from ruby site location"
task "setup:uninstall" do
  if $setup_installed
    sh "setup.rb uninstall"
  else
    puts "Requires stand-alone Setup.rb."
    puts "See http://setup.rubyforge.org"
    puts "or 'gem install setup'."
  end
end

