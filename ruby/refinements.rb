# frozen_string_literal: true

class Integer
  def inspect
    self.to_s.then { self >= 10_000 ? _1.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1_") : _1 }
  end
end

class Float
  def inspect
    whole, fractional = self.to_s.split(".")
    whole.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1_")                        if whole.size > 4
    fractional.reverse!.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1_").reverse! if fractional.size > 4

    "#{whole}.#{fractional}"
  end
end
