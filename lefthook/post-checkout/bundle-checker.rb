#!/usr/bin/ruby

prev_commit = ARGV[0]
post_commit = ARGV[1]
file        = "Gemfile.lock"

if File.file?(file) && prev_commit && post_commit
  diff = `git diff --shortstat #{prev_commit}..#{post_commit} #{file}`
  if diff != ""
    print "  Running bundle install..."
    `bundle install`
    print "  Rebuilding Solagraph docs..."
    `solargraph bundle`
    print "Done!"
  end
end
