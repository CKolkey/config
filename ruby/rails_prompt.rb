# https://docs.ruby-lang.org/en/master/IRB.html#module-IRB-label-Customizing+the+IRB+Prompt

return unless defined?(Rails)

module RailsPrompt
  def self.red(text)   = "\e[31m#{text}\e[0m"
  def self.green(text) = "\e[32m#{text}\e[0m"
  def self.gold(text)  = "\e[33m#{text}\e[0m"
  def self.blue(text)  = "\e[34m#{text}\e[0m"

  def self.env_color(text)
    if Rails.env.production?
      self.red(text)
    elsif Rails.env.development?
      self.green(text)
    elsif Rails.env.integration?
      self.gold(text)
    else
      self.blue(text)
    end
  end

  # def country     = env_color(Site.current.country.upcase)
  def self.environment = env_color(Rails.env.upcase)

  IRB.conf[:PROMPT][:RAILS_PROMPT] = {
    :PROMPT_I => "[#{environment}] (%m)> ",
    :PROMPT_N => "[#{environment}] (%m)> ",
    :PROMPT_S => "[#{environment}] (%m)%l ",
    :PROMPT_C => "[#{environment}] (%m)* ",
    :RETURN   => "=> %s\n"
  }

  IRB.conf[:PROMPT_MODE] = :RAILS_PROMPT

  IRB.conf[:IRB_RC] = Proc.new do
    logger = Logger.new(STDOUT)
    ActiveRecord::Base.logger = logger
  end
end

include RailsPrompt
