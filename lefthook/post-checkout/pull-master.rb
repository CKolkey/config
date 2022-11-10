#!/usr/bin/ruby

HEAD   = `git rev-parse HEAD`.strip
MASTER = `git rev-parse master`.strip
`git pull` if HEAD == MASTER
