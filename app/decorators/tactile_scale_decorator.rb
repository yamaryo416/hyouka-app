# frozen_string_literal: true

class TactileScaleDecorator < ScaleDecorator
  delegate_all

  def limit_part
    limit_part = []
    scale_score.each do |scale|
      next if scale[1].nil?
      value = send("#{scale[0]}_before_type_cast")
      if value <= 1
        limit_part << scale
      end
    end
    limit_part
  end
end
