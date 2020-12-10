# frozen_string_literal: true

module RomScaleDecorator
  include ScaleDecorator

  def limit_part
    limit_part = []
    scale_score.each_with_index do |scale, i|
      next if scale[1].nil?
      if scale[1] <= PART_LIMIT[i]
        limit_part << scale
      end
    end
    limit_part
  end
end
