class FbsScale < ApplicationRecord
  include ScaleModule
  belongs_to :patient

  enum stand_up: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum standing: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum sitting: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum sit_down: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum transfer: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum standing_with_eyes_close: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum standing_with_leg_close: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum reach_forward: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum pickup_from_floor: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum turn_around: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum one_rotation: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum stepup_and_down: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum tandem_standing: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
  }, _prefix: true
  enum standing_with_one_leg: {
    undefined: nil,
    zero: 0,
    trace: 1,
    poor: 2,
    fair: 3,
    good: 4,
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

  def undefined_count
    undefined_count = 0
    attributes.each do |attr_name, value|
      undefined_count += 1 if value.nil?
    end
    undefined_count
  end

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.fbs_scale.#{attr_name}.#{k}"), k] }
  end
end
