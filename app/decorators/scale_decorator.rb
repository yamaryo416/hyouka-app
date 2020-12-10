# frozen_string_literal: true

module ScaleDecorator
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

  def total_score
    total_score = 0
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name) || value.nil?
        next
      else
        score = send("#{attr_name}_before_type_cast")
        total_score += score
      end
    end
    total_score
  end

  def undefined_count
    undefined_count = 0
    attributes.each do |attr_name, value|
      undefined_count += 1 if value.nil?
    end
    undefined_count
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

  BODY_PART.each do |b|
    DIRECTION.each do |d|
      define_method "#{d}_#{b}_scale_score" do
        direction_part_scale_score(b, d)
      end
    end
  end

  DIRECTION.each do |d|
    define_method "#{d}_scale_score" do
      direction_scale_score = {}
      scale_score.each do |attr_name, value|
        if attr_name.include?(d)
          direction_scale_score.store(attr_name, value)
        end
      end
      direction_scale_score
    end
  end
end
