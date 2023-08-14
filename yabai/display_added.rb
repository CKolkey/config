# rubocop:disable Style/GlobalVars

require 'json'
require 'open3'
require 'logger'

$logger = Logger.new("#{Dir.home}/.config/yabai/display_added.log")

class Rules
  def self.home
    [
      { app: '^System Preferences*',                         manage: 'off', border: 'off' },
      { app: '^Cisco Secure Client*',                        manage: 'off', border: 'off' },
      { app: '^Finder$',            title: '(^Copy$)',       manage: 'off', border: 'off' },
      { app: '^Microsoft Outlook$', title: '(Reminder)',     manage: 'off', border: 'off' },
      { app: '^Microsoft Outlook$', title: '\d (Reminders)', manage: 'off', border: 'off' },
      { app: '^Microsoft Outlook$',                                     display: :macbook },
      { app: "Slack",                                                   display: :macbook },
      { app: '^VLC*',                                        manage: 'off', border: 'off' },
      { app: "^kitty$",                                                display: :phillips }
    ]
  end

  def self.work
    []
  end

  def self.mobile
    [
      { app: '^System Preferences*',               manage: 'off', border: 'off' },
      { app: '^Finder$',  title: '(^Copy$)',       manage: 'off', border: 'off' },
      { app: '^VLC*',                              manage: 'off', border: 'off' }
    ]
  end
end

class Display
  DISPLAYS = {
    macbook:  '37D8832A-2D66-02CA-B9F7-8F30A301B230',
    phillips: '489075DF-6790-494E-9CE8-FB32EA6130F5',
    lenovo:   '7D6ED414-BEDC-4B87-8019-B379F36BA5B7',
  }

  attr_reader :name, :spaces, :id, :uuid

  def initialize(opts)
    @id     = opts['index']
    @name   = DISPLAYS.invert[opts['uuid']]
    @spaces = opts["spaces"]
    @uuid   = opts['uuid']
  end
end

class Yabai
  attr_reader :rules

  def initialize(rules)
    @rules = rules
  end

  def yabai(*args)
    Open3.capture3('/opt/homebrew/bin/yabai', *args)
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
    rules << "display=#{displays.find { _1.name == rule.fetch(:display) }.uuid }" if rule[:display]

    rules += rule.filter_map do |k, v|
      next if k == :display

      "#{k}=#{v}"
    end

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
