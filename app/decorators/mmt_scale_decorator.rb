# frozen_string_literal: true

class MmtScaleDecorator < ScaleDecorator
  delegate_all

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

  def neck_trunk_scale_attributes
    neck_trunk_scale_attributes = []
    scale_attributes.each do |attr_name|
      if attr_name.include?("neck") || attr_name.include?("trunk")
        neck_trunk_scale_attributes << attr_name
      end
    end
    neck_trunk_scale_attributes
  end

  BODY_PART.each do |b|
    DIRECTION.each do |d|
      define_method "#{d}_#{b}_scale_attributes" do
        direction_part_scale_attributes(b, d)
      end
    end
  end

  def direction_part_scale_attributes(direction, part)
    direction_part_scale_attributes = []
    scale_attributes.each do |attr_name|
      if attr_name.include?(direction) && attr_name.include?(part)
        direction_part_scale_attributes << attr_name
      end
    end
    direction_part_scale_attributes
  end
end
