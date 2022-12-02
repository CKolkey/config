module RelineFzfPatch
  private

  # When ending a session, Reline writes history separated by newlines.
  # This parses them back into a single-string containing newline-literals
  # for fzf to handle nicely, and for better syntax highlighting
  def __clean_reline_history
    buffer = ''
    Reline::HISTORY.each_with_object([]) do |line, history|
      if line.end_with?('\\')
        buffer += line.sub(/\\$/, "\n")
      elsif buffer.empty?
        history << line
      else
        buffer += line
        history << buffer
        buffer = ''
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
    fzf    = 'fzf --no-info --no-sort --no-multi --ansi --read0 --scheme=history'
    result = IO.popen(fzf, 'r+') do |io|
      io.write(__reline_history_for_fzf)
      io.read
    end

    @line_backup_in_history = whole_buffer
    @buffer_of_lines        = result.empty? ? [''] : result.split("\n")
    @line_index             = @buffer_of_lines.size - 1
    @line                   = @buffer_of_lines.last
    @cursor                 = @cursor_max = calculate_width(@line)
    @byte_pointer           = @line.bytesize
    @rerender_all           = true
  end
end

require 'reline'
Reline::LineEditor.prepend(RelineFzfPatch)
