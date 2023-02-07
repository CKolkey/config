module ClipboardIO
  def paste
    `pbpaste`
  end

  def copy(str)
    IO.popen("pbcopy", "w") { |f| f << str.to_s }
    puts "Copied to clipboard"
  end

  def copy_history
    history = Reline::HISTORY
    index   = history.rindex("exit") || -1
    content = history[(index + 1)..-2].join("\n")
    puts content
    copy content
  end
end

include ClipboardIO if RUBY_PLATFORM.include?("darwin")
