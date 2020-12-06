# frozen_string_literal: true

module BestestScaleDecorator
  include ScaleDecorator
  
  def apa_score
    apa_score = 0
    APA_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        apa_score += score
      end
    end
    apa_score
  end

  def cpa_score
    cpa_score = 0
    CPA_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        cpa_score += score
      end
    end
    cpa_score
  end

  def sensory_function_score
    sensory_function_score = 0
    SENSORY_FUNCTION_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        sensory_function_score += score
      end
    end
    sensory_function_score
  end

  def dynamic_walking_score
    dynamic_walking_score = 0
    DYNAMIC_WALKING_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        dynamic_walking_score += score
      end
    end
    dynamic_walking_score
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
end
