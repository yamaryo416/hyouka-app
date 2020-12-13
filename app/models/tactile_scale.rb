class TactileScale < ApplicationRecord
  include Scope

  belongs_to :patient
  enum right_upper_arm: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_upper_arm: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_forearm: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_forearm: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_hand: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_hand: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_thigh: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_thigh: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_lower_leg: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_lower_leg: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_rearfoot: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_rearfoot: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_forefoot: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_forefoot: {
    undefined: nil,
    absent: 0,
    impaired: 1,
    normal: 2,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.tactile_scale.#{attr_name}.#{k}"), k] }
  end
end
