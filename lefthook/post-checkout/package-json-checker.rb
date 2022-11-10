#!/usr/bin/ruby

prev_commit = ARGV[0]
post_commit = ARGV[1]
file        = "package.json"

if File.file?(file) && prev_commit && post_commit
  diff = `git diff --shortstat #{prev_commit}..#{post_commit} #{file}`
  if diff != ""
    print "  Running yarn install..."
    `yarn install`
    print "Done!"
  end
end
