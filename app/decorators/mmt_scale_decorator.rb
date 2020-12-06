# frozen_string_literal: true

module MmtScaleDecorator
  include ScaleDecorator

  def neck_trunk_each_score
    neck_trunk_each_score = {}
    each_score.each do |attr_name, value|
      if attr_name.include?("neck") || attr_name.include?("trunk")
        neck_trunk_each_score.store(attr_name, value)
      end
    end
    neck_trunk_each_score
  end
end
