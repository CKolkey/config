function __hvst_once_per_day --on-event fish_prompt
    set -l today (date +%F)

    if test "$HVST_LAST_RUN" != "$today"
        hvst
        set -U HVST_LAST_RUN $today
    end
end
# #!/usr/bin/env ruby
#
# # frozen_string_literal: true
#
# abort "You need to install FZF: https://github.com/junegunn/fzf" unless system("which fzf", out: File::NULL)
#
# require "bundler/inline"
# require "date"
#
# gemfile do
#   source "https://rubygems.org"
#   gem "httpx"
# end
#
#
# def fzf(choices, prompt:)
#   IO.popen("fzf --layout=reverse --no-info --no-multi --read0 --prompt='#{prompt}: '", "r+") do |io|
#     io.write(choices.uniq.join("\0"))
#     io.close_write
#     io.read
#   end.chomp
# end
#
# headers = {
#   "Harvest-Account-ID" => 0,
#   "Authorization" => "Bearer xx"
# }
#
# def endpoint(path) = "https://api.harvestapp.com/api/v2/#{path}"
#
# response = HTTPX.with(headers:)
#   .get(endpoint("users/me/project_assignments"))
#   .json
#   .fetch("project_assignments")
#   .select { _1.fetch("is_active") }
#
# projects = response.map { "#{_1.dig("project", "id")} - #{_1.dig("project", "name") }" }
#
# project_id, project_name = fzf(projects, prompt: "Project").split(" - ")
# project = response.find { _1.dig("project", "id") == project_id.to_i }
# exit(1) if project.nil?
#
# tasks = project.fetch("task_assignments").map { "#{_1.dig("task", "id")} - #{_1.dig("task", "name") }" }
# task_id, task_name = fzf(tasks, prompt: project_name).split(" - ")
# exit(1) if task_id.nil?
#
# begin
#   puts `clear`
#   puts "#{project_name}, #{task_name}"
#   puts "Full day?"
#   print "[y/n] > "
#   if gets.chomp == "y"
#     hours = 7
#     minutes = 30
#   else
#     hours = ""
#     minutes = ""
#     until hours != "" && minutes != ""
#       puts `clear`
#       puts "#{project_name}, #{task_name}"
#
#       if hours == ""
#         print "Hours > #{hours}"
#         hours = gets.chomp
#       else
#         puts  "Hours > #{hours}"
#         print "Mins  > #{minutes}"
#         minutes = gets.chomp
#       end
#     end
#   end
#
#   HTTPX.with(headers: { **headers, "Content-Type" => "application/json" })
#     .post(
#       endpoint("time_entries"),
#       body: {
#         project_id:,
#         task_id:,
#         spent_date: Date.today.iso8601,
#         hours: hours.to_i + (minutes.to_i / 60.0)
#       }.to_json
#     )
# rescue Interrupt, NoMethodError
#   exit(1)
# end
