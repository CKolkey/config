IRB::TOPLEVEL_BINDING.eval(<<~RUBY)
  def q
    exit 0
  end

  def clear
    puts `clear`
  end
RUBY
