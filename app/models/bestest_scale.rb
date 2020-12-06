class BestestScale < ApplicationRecord
  belongs_to :patient
  enum from_sitting_to_standing: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum standing_on_tiptoes: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum standing_on_one_leg: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum forward_step: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum back_step: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum lateral_step: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum standing: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum standing_with_eyes_close: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum standing_on_the_slope: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum change_walking_speed: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum walking_with_rotating_the_head: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum pibot_turn: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum straddling_obstacles: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true
  enum tug: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.bestest_scale.#{attr_name}.#{k}"), k] }
  end
end
