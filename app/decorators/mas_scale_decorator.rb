# frozen_string_literal: true

class MasScaleDecorator < ScaleDecorator
  delegate_all

  def hypertonia_part
    hypertonia_part = []
    scale_score.each do |scale|
      next if scale[1].nil?
      value = send("#{scale[0]}_before_type_cast")
      if value >= 2
        hypertonia_part << scale
      end
    end
    hypertonia_part
  end
end
