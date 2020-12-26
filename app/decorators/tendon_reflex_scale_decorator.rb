# frozen_string_literal: true

class TendonReflexScaleDecorator < ScaleDecorator
  delegate_all

  def hyperreflexia_part
    hyperreflexia_part = []
    scale_score.each do |scale|
      next if scale[1].nil?
      value = send("#{scale[0]}_before_type_cast")
      if value >= 3
        hyperreflexia_part << scale
      end
    end
    hyperreflexia_part
  end

  def hyporeflexia_part
    hyporeflexia_part = []
    scale_score.each do |scale|
      next if scale[1].nil?
      value = send("#{scale[0]}_before_type_cast")
      if value <= 1
        hyporeflexia_part << scale
      end
    end
    hyporeflexia_part
  end
end
