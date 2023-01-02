# https://github.com/nevir/Bumbler
# http://patkoperwas.github.io/code/profiling-rails-boot-time.html
# require in bin/rails at the top
# run via: $ time bundle exec rake environment | sort

module RequireBenchmarking
  def require(file_name)
    result = nil
    time   = Benchmark.realtime { result = super }.round(3)
    color  = case time
             when 0.1..0.2 then 2 # Green
             when 0.2..1.0 then 3 # Yellow
             when 1..100   then 1 # Red
             end

    puts "\e[3#{color}m#{time}\e[0m\t#{file_name}" if (0.1..20).cover?(time)
    result
  end

  # magic via https://github.com/rubyworks/backload/blob/master/lib/backload/require_relative.rb
  def require_relative(file_name)
    c = caller(1..1).first
    raise "Can't parse #{c}" unless c.rindex(/:\d+(:in `.*')?$/)

    file = ::Regexp.last_match.pre_match # File.dirname(c)
    raise LoadError, "require_relative is called in #{::Regexp.last_match(1)}" if /\A\((.*)\)/.match?(file)

    require(File.expand_path(file_name, File.dirname(file)))
  end
end

if ENV['BENCHMARK']
  require 'benchmark'
  Kernel.prepend(RequireBenchmarking)
end
