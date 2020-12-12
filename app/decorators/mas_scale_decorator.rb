# frozen_string_literal: true

module MasScaleDecorator
  include ScaleDecorator

  def hypertonia_part
    hypertonia_part = []
    scale_score.each_with_index do |scale, i|
      next if scale[1].nil?
      value = send("#{scale[0]}_before_type_cast")
      if value >= 2
        hypertonia_part << scale
      end
    end
    hypertonia_part
  end
end
