# gems = %w[
#   active_support
#   awesome_print
# ]
#
# libs = %w[
#   base64
#   benchmark
#   fileutils
#   json
#   securerandom
#   stringio
#   time
#   uri
# ]
#
# (gems + libs).each do |pkg|
#   require pkg
# rescue Object => e
#   puts "Couldn't require #{pkg}"
# end
#

begin
  require "#{Dir.home}/.config/ruby/clipboard_io"
  require "#{Dir.home}/.config/ruby/reline_fzf_patch"
  require "#{Dir.home}/.config/ruby/object_helpers"
  require "awesome_print"
rescue LoadError => e
  puts "Error Loading rdbgrc (#{e})"
end
