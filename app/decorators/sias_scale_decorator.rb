# frozen_string_literal: true

class SiasScaleDecorator < ScaleDecorator
  delegate_all

  def total_score
    total_score = 0
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name) || value.nil?
        next
      else
        score = send("#{attr_name}_before_type_cast")
        if !score.integer?
          total_score += score.floor
        else
          total_score += score
        end
      end
    end
    total_score
  end
end
