# frozen_string_literal: true

module RelineAutocompletePatch
  def bg_color
    40
  end

  def pointer_bg_color
    41
  end
end

Reline::DialogRenderInfo.prepend(RelineAutocompletePatch) if defined?(Reline::DialogRenderInfo)
