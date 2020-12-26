class FbsScale < ApplicationRecord
  include Scope

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

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.fbs_scale.#{attr_name}.#{k}"), k] }
  end
end
