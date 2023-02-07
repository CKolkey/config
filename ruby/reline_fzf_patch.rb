module RelineFzfPatch
  private

  RELINE_PATCH_LINE_TERMINATOR = "\\".freeze

  # When ending a session, Reline writes history separated by newlines.
  # This parses them back into a single-string containing newline-literals
  # for fzf to handle nicely, and for better syntax highlighting
  def __clean_reline_history
    buffer = ""
    Reline::HISTORY.each_with_object([]) do |line, history|
      next if line.size < 2

      if line.end_with?(RELINE_PATCH_LINE_TERMINATOR)
        buffer += line.sub(/\\$/, "\n")
      elsif buffer.empty?
        history << line
      else
        history << (buffer + line)
        buffer = ""
      end
    end
  end

  def __reline_history_for_fzf
    __clean_reline_history
      .reverse
      .uniq
      .map { IRB::Color.colorize_code(_1, ignore_error: true) }
      .join("\0")
  end

  def incremental_search_history(_)
    fzf    = "fzf --no-info --no-sort --no-multi --ansi --read0 --scheme=history"
    result = IO.popen(fzf, "r+") do |io|
      io.write(__reline_history_for_fzf)
      io.close_write
      io.read
    end

    @line_backup_in_history = whole_buffer
    @buffer_of_lines        = result.empty? ? [""] : result.split("\n")
    @line_index             = @buffer_of_lines.size - 1
    @line                   = @buffer_of_lines.last
    @cursor_max             = calculate_width(@line)
    @cursor                 = @cursor_max
    @byte_pointer           = @line.bytesize
    @rerender_all           = true
  end
end

require "reline"
Reline::LineEditor.prepend(RelineFzfPatch)




