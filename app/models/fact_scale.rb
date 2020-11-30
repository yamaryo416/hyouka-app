class FactScale < ApplicationRecord
  include ScaleModule
  belongs_to :patient
  enum sitting_with_upper_limb_support: {
    undefined: nil,
    impossible: 0,
    possible: 1,
  }, _prefix: true
  enum sitting_with_no_support: {
    undefined: nil,
    impossible: 0,
    possible: 1,
  }, _prefix: true
  enum lower_lateral_dynamic_sitting: {
    undefined: nil,
    impossible: 0,
    possible: 1,
  }, _prefix: true
  enum forward_dynamic_sitting: {
    undefined: nil,
    impossible: 0,
    possible: 2,
  }, _prefix: true
  enum lateral_dynamic_sitting: {
    undefined: nil,
    impossible: 0,
    one_side: 1,
    both_sides: 2,
  }, _prefix: true
  enum rear_lateral_dynamic_sitting: {
    undefined: nil,
    impossible: 0,
    one_side: 1,
    both_sides: 2,
  }, _prefix: true
  enum rear_dynamic_sitting: {
    undefined: nil,
    impossible: 0,
    possible: 2,
  }, _prefix: true
  enum lateral_dynamic_sitting_with_trunk_rotation: {
    undefined: nil,
    impossible: 0,
    possible: 3,
  }, _prefix: true
  enum trunk_rotation: {
    undefined: nil,
    impossible: 0,
    possible: 3,
  }, _prefix: true
  enum trunk_extenxion: {
    undefined: nil,
    impossible: 0,
    possible: 3,
  }, _prefix: true

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

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.fact_scale.#{attr_name}.#{k}"), k] }
  end
end
