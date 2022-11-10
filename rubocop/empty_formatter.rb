# frozen_string_literal: true

class EmptyFormatter < RuboCop::Formatter::BaseFormatter
  def file_finished(*)
    # no-op
  end
end
