# frozen_string_literal: true

module HdsrScaleDecorator
  include ScaleDecorator

  def total_score
    total_score = 0
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name) || value.nil?
        next
      else
        total_score += value
      end
    end
    total_score
  end
end
