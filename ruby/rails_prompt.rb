# https://docs.ruby-lang.org/en/master/IRB.html#module-IRB-label-Customizing+the+IRB+Prompt

return unless defined?(Rails)

module RailsPrompt
  BOLD  = ->(text) { "\033[1m#{text}\033[0m" }
  RED   = ->(text) { "\e[31m#{text}\e[0m" }
  GREEN = ->(text) { "\e[32m#{text}\e[0m" }
  BLUE  = ->(text) { "\e[34m#{text}\e[0m" }

  def self.formatted_env
    if Rails.env.production?
      BOLD.call(RED.call(Rails.env.upcase))
    elsif Rails.env.development?
      GREEN.call(Rails.env.upcase[0, 3])
    else
      BLUE.call(Rails.env.upcase)
    end
  end

  IRB.conf[:PROMPT][:RAILS_PROMPT] = {
    PROMPT_I: "[#{formatted_env}] (%m)> ",
    PROMPT_N: "[#{formatted_env}] (%m)> ",
    PROMPT_S: "[#{formatted_env}] (%m)%l ",
    PROMPT_C: "[#{formatted_env}] (%m)* ",
    RETURN: "=> %s\n"
  }

  IRB.conf[:PROMPT_MODE] = :RAILS_PROMPT
end

include RailsPrompt
