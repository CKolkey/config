# https://github.com/nevir/Bumbler
# http://patkoperwas.github.io/code/profiling-rails-boot-time.html
# require in bin/rails at the top
# run via: $ time bundle exec rake environment | sort

# rubocop:disable Style/GlobalVars
module RequireBenchmarking
  class GlobalRequires
    attr_reader :required

    def initialize
      @required = {}
    end

    def add(file, time)
      @required[file] = time

      print(file, time) if (0.1..20).cover?(time)
    end

    def slowest(n = 10)
      @required.to_a.sort_by(&:last).reverse.first(n).each { |file, time| print(file, time) }
    end

    def print(file, time)
      color = case time
              when 0.1..0.2 then 2 # Green
              when 0.2..1.0 then 3 # Yellow
              when 1..100   then 1 # Red
              end

      puts "\e[3#{color}m#{time}\e[0m\t#{file}"
    end
  end

  $__REQUIRED = GlobalRequires.new

  alias_method :__original_require, :require
  alias_method :__original_require_relative, :require_relative

  def require(file_name)
    result = nil
    time   = Benchmark.realtime { result = __original_require(file_name) }.round(3)
    $__REQUIRED.add(file_name, time)

    result
  end

  # magic via https://github.com/rubyworks/backload/blob/master/lib/backload/require_relative.rb
  # def require_relative(file_name)
  #   c = caller(1..1).first
  #   raise "Can't parse #{c}" unless c.rindex(/:\d+(:in `.*')?$/)
  #
  #   file = ::Regexp.last_match.pre_match # File.dirname(c)
  #   raise LoadError, "require_relative is called in #{::Regexp.last_match(1)}" if /\A\((.*)\)/.match?(file)
  #
  #   require(File.expand_path(file_name, File.dirname(file)))
  # end

  def require_relative(file_name)
    file_name = if Pathname.new(file_name).absolute?
                  file_name
                else
                  relative_from = caller_locations(1..1).first
                  relative_from_path = relative_from.absolute_path || relative_from.path
                  File.expand_path("../#{file_name}", relative_from_path)
                end

    require file_name
  end
end

if ENV["BENCHMARK"]
  require "benchmark"
  Kernel.prepend(RequireBenchmarking)
end
# rubocop:enable Style/GlobalVars
