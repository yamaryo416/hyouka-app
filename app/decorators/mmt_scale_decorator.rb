# frozen_string_literal: true

module MmtScaleDecorator
  include ScaleDecorator

  def weak_part
    weak_part = []
    scale_score.each do |scale|
      next if scale[1].nil?
      value = send("#{scale[0]}_before_type_cast")
      if value <= 3
        weak_part << scale
      end
    end
    weak_part
  end

  def neck_trunk_scale_score
    neck_trunk_scale_score = {}
    scale_score.each do |attr_name, value|
      if attr_name.include?("neck") || attr_name.include?("trunk")
        neck_trunk_scale_score.store(attr_name, value)
      end
    end
    neck_trunk_scale_score
  end
end
