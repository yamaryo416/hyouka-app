# frozen_string_literal: true

class BathyesthesiaScaleDecorator < ScaleDecorator
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

  DIRECTION.each do |d|
    define_method "#{d}_position_sense_scale_attributes" do
      position_sense_scale_attributes = []
      send("#{d}_scale_attributes").each do |attr_name|
        if attr_name.include?("limb")
          position_sense_scale_attributes << attr_name
        end
      end
      position_sense_scale_attributes
    end
  end

  DIRECTION.each do |d|
    define_method "#{d}_motor_sense_scale_attributes" do
      motor_sense_scale_attributes = []
      send("#{d}_scale_attributes").each do |attr_name|
        if !attr_name.include?("limb")
          motor_sense_scale_attributes << attr_name
        end
      end
      motor_sense_scale_attributes
    end
  end
end
