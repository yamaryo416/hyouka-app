# frozen_string_literal: true

class ScaleDecorator < ApplicationDecorator
  delegate_all

  def scale_attributes
    scale_attributes = []
    attributes.keys.each do |attr_name|
      if EXCLUDE_COLUMNS.include?(attr_name)
        next
      else
        scale_attributes << attr_name
      end
    end
    scale_attributes
  end

  def scale_score
    scale_score = {}
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name)
        next
      else
        scale_score.store(attr_name, value)
      end
    end
    scale_score
  end

  # bestest_scale, fact_scale, fbs_scale
  def total_score
    total_score = 0
    scale_score.each do |attr_name, value|
      next if value.nil?
      score = send("#{attr_name}_before_type_cast")
      total_score += score
    end
    total_score
  end

  # bestest_scale, fact_scale, fbs_scale, hdsr_scale, sias_scale
  def undefined_count
    undefined_count = 0
    scale_score.each do |attr_name, value|
      undefined_count += 1 if value.nil?
    end
    undefined_count
  end

  # mas_scale, tactile_scale, tendon_reflex_scale
  DIRECTION.each do |d|
    define_method "#{d}_scale_attributes" do
      direction_scale_attributes = []
      scale_attributes.each do |attr_name|
        if attr_name.include?(d)
          direction_scale_attributes << attr_name
        end
      end
      direction_scale_attributes
    end
  end
end
