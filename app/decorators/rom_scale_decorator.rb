# frozen_string_literal: true

class RomScaleDecorator < ScaleDecorator
  delegate_all

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

  BODY_PART.each do |b|
    DIRECTION.each do |d|
      define_method "#{d}_#{b}_scale_score" do
        direction_part_scale_score(b, d)
      end
    end
  end

  def direction_part_scale_score(direction, part)
    direction_part_scale_score = {}
    attributes.each do |attr_name, value|
      if attr_name.include?(direction) && attr_name.include?(part)
        direction_part_scale_score.store(attr_name, value)
      end
    end
    direction_part_scale_score
  end
end
