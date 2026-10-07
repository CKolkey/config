function __hvst_once_per_day --on-event fish_prompt
    set -l today (date +%F)

    if test "$HVST_LAST_RUN" != "$today"
        hvst
        set -U HVST_LAST_RUN $today
    end
end

# #!/usr/bin/env ruby
#
# require "bundler/inline"
#
# gemfile do
#   source "https://rubygems.org"
#   gem "httpx"
#   gem "tty-prompt"
#   gem "date"
# end
#
# exit(0) if Date.today.sunday? || Date.today.saturday?
#
# headers = {
#   "Harvest-Account-ID" => 0,
#   "Authorization" => "Bearer xxx"
# }
#
# def endpoint(path) = "https://api.harvestapp.com/api/v2/#{path}"
#
# def submit = system("open", "https://karnovgroup.harvestapp.com/time/week/")
#
# if ARGV[0] == "submit"
#   submit
#   exit(0)
# end
#
# response = HTTPX.with(headers:)
#   .get(endpoint("users/me/project_assignments"))
#   .json
#   .fetch("project_assignments")
#   .select { _1.fetch("is_active") }
#
# prompt = TTY::Prompt.new
# puts `clear`
#
# begin
#   project_id = response.map { [_1.dig("project", "name"), _1.dig("project", "id")] }
#                        .sort
#                        .to_h
#                        .tap { _1["None"] = nil }
#                        .then { |projects| prompt.enum_select("Project", projects) }
#
#   exit(0) if project_id.nil?
#
#   task_id = response.find { _1.dig("project", "id") == project_id }
#                     .fetch("task_assignments")
#                     .map { [_1.dig("task", "name"), _1.dig("task", "id")] }
#                     .sort
#                     .to_h
#                     .then { |tasks| prompt.enum_select("Task", tasks) }
#
#   exit(0) if task_id.nil?
#
#   hours = 7
#   minutes = 30
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
#
#   submit if Date.today.friday?
# rescue Interrupt, NoMethodError
#   exit(1)
# end
