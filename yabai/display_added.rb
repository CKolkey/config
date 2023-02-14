# rubocop:disable Style/GlobalVars

require 'json'
require 'open3'
require 'logger'

$logger = Logger.new("#{Dir.home}/.config/yabai/display_added.log")

class Rules
  def self.home
    [
      { app: '^System Preferences*',               manage: 'off', border: 'off' },
      { app: '^Finder$',  title: '(^Copy$)',       manage: 'off', border: 'off' },
      { app: '^Microsoft Outlook$', title: '(Reminder)',     manage: 'off', border: 'off' },
      { app: '^Microsoft Outlook$', title: '\d (Reminders)', manage: 'off', border: 'off' },
      { app: '^Microsoft Outlook$', display: :macbook },
      { app: "Slack", display: :macbook },
      { app: '^VLC*',                              manage: 'off', border: 'off' },
      { app: "^kitty$", display: :lenovo }
    ]
  end

  def self.work
    []
  end

  def self.mobile
    [
      { app: '^System Preferences*',               manage: 'off', border: 'off' },
      { app: '^Finder$',  title: '(^Copy$)',       manage: 'off', border: 'off' },
      { app: '^Outlook$', title: '(Reminder)',     manage: 'off', border: 'off' },
      { app: '^Outlook$', title: '\d (Reminders)', manage: 'off', border: 'off' },
      { app: '^VLC*',                              manage: 'off', border: 'off' }
    ]
  end
end

class Display
  DISPLAYS = {
    macbook: 'F6C43BE9-0505-9F49-91F0-911B4FAD3323', # need solution for M1 too
    samsung: '38302423-DFEB-83AD-2376-8D659CB33836',
    lenovo: 'E23DEDEA-D97F-1A22-84EF-542CD08F4588',
    dell: 'TBD' # office screens
  }

  attr_reader :name, :spaces, :id

  def initialize(opts)
    @id     = opts['index']
    @name   = DISPLAYS.invert[opts['uuid']]
    @spaces = opts["spaces"]
  end
end

class Yabai
  attr_reader :rules

  def initialize(rules)
    @rules = rules
  end

  def yabai(*args)
    Open3.capture3('/usr/local/bin/yabai', *args)
  end

  def displays
    @displays ||= begin
      out, err, status = yabai('-m', 'query', '--displays')

      unless status.success?
        $logger.debug("[DISPLAYS] Error: #{err}")
        exit 1
      end

      JSON.parse(out).map { |opts| Display.new(opts) }
    end
  end

  def setup_home!
    rules.home.each { |rule| add_rule(rule) }
  end

  def setup_mobile!
    rules.mobile.each { |rule| add_rule(rule) }
  end

  def setup_work!
    rules.work.each { |rule| add_rule(rule) }
  end

  def delete_all_rules!
    loop do
      _out, _err, status = yabai('-m', 'rule', '--remove', '0')
      break if status != 0
    end
  end

  private

  def add_rule(rule)
    rule = format_rule(rule)
    $logger.info("> Adding rule: '#{rule}'")
    yabai('-m', 'rule', '--add', *rule)
  end

  def format_rule(rule)
    rules = []
    rules << "app='#{rule.delete(:app)}'"
    rules << "title='#{rule.delete(:title)}'" if rule[:title]
    rules << "display=#{displays.find { |d| d.name == rule.delete(:display) }.id}" if rule[:display]
    rules += rule.map { |k, v| "#{k}=#{v}" }
    rules
  end
end

begin
  yabai = Yabai.new(Rules)
  yabai.delete_all_rules!

  connected_displays = yabai.displays.map(&:name)

  if connected_displays.size == 3
    $logger.info('Connected to Home Office')
    yabai.setup_home!
  elsif connected_displays.size == 2 && connected_displays.include?(:macbook)
    $logger.info('Connected to Work Office')
    yabai.setup_work!
  else
    $logger.info('Setting up Mobile')
    yabai.setup_mobile!
  end

  $logger.info('---')
rescue StandardError => e
  $logger.error(e)
  exit 1
end
# rubocop:enable Style/GlobalVars
