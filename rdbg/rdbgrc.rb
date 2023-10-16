begin
  require "#{Dir.home}/.config/ruby/clipboard_io"
  require "#{Dir.home}/.config/ruby/reline_fzf_patch"
  require "#{Dir.home}/.config/ruby/object_helpers"
  require "awesome_print"
rescue LoadError => e
  puts "Error Loading rdbgrc (#{e})"
end
