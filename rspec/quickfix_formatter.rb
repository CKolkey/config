# frozen_string_literal: true

require "rspec/core/formatters/base_formatter"

class QuickfixFormatter < RSpec::Core::Formatters::BaseFormatter
  def dump_failures(notification)
    notification.failed_examples.each do |e|
      output.puts "#{e.metadata[:absolute_file_path]}:#{e.metadata[:line_number]}: #{e.example_group.description}: #{e.description}\n"
    end
  end
end

RSpec::Core::Formatters.register QuickfixFormatter, :dump_failures
