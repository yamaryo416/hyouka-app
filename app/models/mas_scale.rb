class MasScale < ApplicationRecord
  belongs_to :patient
  enum elbow_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum wrist_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum knee_joint: {
    undefined: nil,
    no_enhancement: 1,
    mild_enhancement: 2,
    mild_increase: 3,
    increase: 4,
    significant: 5,
    rigidity: 6,
  }, _prefix: true
  enum ankle_joint: {
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
