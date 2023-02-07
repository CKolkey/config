# frozen_string_literal: true

require "rspec/core/formatters/base_formatter"

class FilepathFormatter < RSpec::Core::Formatters::BaseFormatter
  def dump_failures(notification)
    notification.failed_examples.each do |e|
      output.puts "#{e.metadata[:absolute_file_path]}\n"
    end
  end
end

RSpec::Core::Formatters.register FilepathFormatter, :dump_failures
