# frozen_string_literal: true

module ScaleDecorator
  def each_score
    each_score = {}
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name)
        next
      else
        each_score.store(attr_name, value)
      end
    end
    each_score
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

  def direction_part_each_score(direction, part)
    direction_part_each_score = {}
    each_score.each do |attr_name, value|
      if attr_name.include?(direction) && attr_name.include?(part)
        direction_part_each_score.store(attr_name, value)
      end
    end
    direction_part_each_score
  end

  BODY_PART.each do |b|
    DIRECTION.each do |d|
      define_method "#{d}_#{b}_each_score" do
        direction_part_each_score(b, d)
      end
    end
  end

  DIRECTION.each do |d|
    define_method "#{d}_each_score" do
      direction_each_score = {}
      each_score.each do |attr_name, value|
        if attr_name.include?(d)
          direction_each_score.store(attr_name, value)
        end
      end
      direction_each_score
    end
  end
end
