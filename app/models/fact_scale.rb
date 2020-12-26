class FactScale < ApplicationRecord
  include Scope

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

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.fact_scale.#{attr_name}.#{k}"), k] }
  end
end
