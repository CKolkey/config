begin
  require "#{Dir.home}/.config/irb/irbrc"
rescue LoadError => e
  puts "Error loading rbdgrc: #{e.message}"
end
