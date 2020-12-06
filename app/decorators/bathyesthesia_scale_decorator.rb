# frozen_string_literal: true

module BathyesthesiaScaleDecorator
  include ScaleDecorator

  DIRECTION.each do |d|
    define_method "#{d}_position_sense_each_score" do
      position_sense_each_score = {}
      send("#{d}_each_score").each do |attr_name, value|
        if attr_name.include?("limb")
          position_sense_each_score.store(attr_name, value)
        end
      end
      position_sense_each_score
    end
  end

  DIRECTION.each do |d|
    define_method "#{d}_motor_sense_each_score" do
      motor_sense_each_score = {}
      send("#{d}_each_score").each do |attr_name, value|
        if !attr_name.include?("limb")
          motor_sense_each_score.store(attr_name, value)
        end
      end
      motor_sense_each_score
    end
  end
end
