# frozen_string_literal: true

module BathyesthesiaScaleDecorator
  include ScaleDecorator

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
    define_method "#{d}_position_sense_scale_score" do
      position_sense_scale_score = {}
      send("#{d}_scale_score").each do |attr_name, value|
        if attr_name.include?("limb")
          position_sense_scale_score.store(attr_name, value)
        end
      end
      position_sense_scale_score
    end
  end

  DIRECTION.each do |d|
    define_method "#{d}_motor_sense_scale_score" do
      motor_sense_scale_score = {}
      send("#{d}_scale_score").each do |attr_name, value|
        if !attr_name.include?("limb")
          motor_sense_scale_score.store(attr_name, value)
        end
      end
      motor_sense_scale_score
    end
  end
end
