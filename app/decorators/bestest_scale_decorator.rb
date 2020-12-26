# frozen_string_literal: true

class BestestScaleDecorator < ScaleDecorator
  delegate_all

  def apa_score
    apa_score = 0
    BestestScale::APA_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        apa_score += score
      end
    end
    apa_score
  end

  def cpa_score
    cpa_score = 0
    BestestScale::CPA_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        cpa_score += score
      end
    end
    cpa_score
  end

  def sensory_function_score
    sensory_function_score = 0
    BestestScale::SENSORY_FUNCTION_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        sensory_function_score += score
      end
    end
    sensory_function_score
  end

  def dynamic_walking_score
    dynamic_walking_score = 0
    BestestScale::DYNAMIC_WALKING_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        dynamic_walking_score += score
      end
    end
    dynamic_walking_score
  end
end
