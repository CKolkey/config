IRB::TOPLEVEL_BINDING.eval(<<~RUBY)
  def r(lib)
    require lib
  end

  def rr(lib)
    require_relative lib
  end

  def q
    exit 0
  end

  def clear
    puts `clear`
  end
RUBY
