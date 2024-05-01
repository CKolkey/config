# frozen_string_literal: true

class Integer
  # def underscore(s=3)
  #   self.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1_")
  # end
  #
  # Via Awesome Print gem. Reformats numbers to include underscores as delimiters.
  def ai(...)
    _, pre, number, post = super(...).match(%r{(\e\[1;34m)(\d+)(\e\[0m)}).to_a

    [
      pre,
      number.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1_"),
      post
    ].join
  end
end
