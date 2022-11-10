require "set"
require "vcr"
require "pathname"

USED_CASSETTES = Set.new

def unused_vcr_cassettes
  @unused_vcr_cassettes ||= begin
    all_cassettes = Dir[File.join(VCR.configuration.cassette_library_dir, "**/*.yml")]
    all_cassettes.map! { File.expand_path(_1) }

    all_cassettes - USED_CASSETTES.to_a
  end
end

def prune_unused_cassettes
  puts "\nPruning #{unused_vcr_cassettes.size} unused VCR cassettes"
  unused_vcr_cassettes.each { |f| FileUtils.rm(f) }
end

def print_unused_cassettes
  puts "\nUnused VCR cassettes: #{unused_vcr_cassettes.size}"
  unused_vcr_cassettes.map { |f| puts Pathname.new(f).relative_path_from(Dir.pwd) }
end

def print_unused_cassette_results
  return if unused_vcr_cassettes.none?

  print_unused_cassettes
  prune_unused_cassettes if ENV["PRUNE_CASSETTES"]
end

def entire_suite_run?(config)
  config.files_to_run.size == Dir["spec/**/*_spec.rb"].size
end

RSpec.configure do |config|
  config.after(:suite) { print_unused_cassette_results if entire_suite_run?(config) }
end

module CassetteReporter
  def insert_cassette(name, options = {})
    USED_CASSETTES << VCR::Cassette.new(name, options).file
    super
  end
end
VCR.extend(CassetteReporter)
