class MasScale < ApplicationRecord
  include Scope

  belongs_to :patient
  enum right_elbow_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum left_elbow_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum right_wrist_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum left_wrist_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum right_knee_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum left_knee_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum right_ankle_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum left_ankle_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.mas_scale.#{attr_name}.#{k}"), k] }
  end
end
