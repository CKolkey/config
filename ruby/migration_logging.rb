# frozen_string_literal: true

module MigrationLoggingImprovements
  def announce(message)
    text = "#{version} #{name}: #{message}"
    length = [0, 75 - text.length].max
    write yellow("== %s %s" % [text, "=" * length])
  end

  def say(message, subitem = false)
    prefix = subitem ? "   ->" : "--"
    write "#{dim(prefix)} #{message}"
  end

  def say_with_time(message)
    say(message)
    result = nil
    time = Benchmark.measure { result = yield }
    say dim("%.4fs" % time.real), :subitem
    say("#{result} rows", :subitem) if result.is_a?(Integer)
    result
  end

  private

  def colorize(text, color_code)
    if $stdout.tty?
      "\e[#{color_code}m#{text}\e[0m"
    else
      text
    end
  end

  def bold(text) = colorize(text, 1)
  def dim(text) = colorize(text, 2)
  def red(text) = colorize(text, 31)
  def green(text) = colorize(text, 32)
  def yellow(text) = colorize(text, 33)
end

ActiveRecord::Migration.prepend(MigrationLoggingImprovements) if defined?(ActiveRecord::Migration)
