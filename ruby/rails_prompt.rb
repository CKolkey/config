# https://docs.ruby-lang.org/en/master/IRB.html#module-IRB-label-Customizing+the+IRB+Prompt
module RailsPrompt
  def self.formatted_env
    bold  = ->(text) { "\033[1m#{text}\033[0m" }
    red   = ->(text) { "\e[31m#{text}\e[0m" }
    green = ->(text) { "\e[32m#{text}\e[0m" }
    blue  = ->(text) { "\e[34m#{text}\e[0m" }

    if Rails.env.production?
      bold.call(red.call(Rails.env.upcase))
    elsif Rails.env.development?
      green.call(Rails.env.upcase[0, 3])
    else
      blue.call(Rails.env.upcase)
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
