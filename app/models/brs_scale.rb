class BrsScale < ApplicationRecord
  include Scope

  belongs_to :patient
  enum upper_limb: {
    undefined: nil,
    stage_one: 1,
    stage_two: 2,
    stage_three: 3,
    stage_four: 4,
    stage_five: 5,
    stage_six: 6,
  }, _prefix: true
  enum finger: {
    undefined: nil,
    stage_one: 1,
    stage_two: 2,
    stage_three: 3,
    stage_four: 4,
    stage_five: 5,
    stage_six: 6,
  }, _prefix: true
  enum lower_limb: {
    undefined: nil,
    stage_one: 1,
    stage_two: 2,
    stage_three: 3,
    stage_four: 4,
    stage_five: 5,
    stage_six: 6,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.brs_scale.#{attr_name}.#{k}"), k] }
  end
end
