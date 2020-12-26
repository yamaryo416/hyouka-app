class BathyesthesiaScale < ApplicationRecord
  include Scope

  belongs_to :patient
  enum right_upper_limb: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_upper_limb: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_lower_limb: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_lower_limb: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_finger: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_finger: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum right_toe: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true
  enum left_toe: {
    undefined: nil,
    impaired: 1,
    normal: 2,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.
      map { |k| [I18n.t("enums.bathyesthesia_scale.#{attr_name}.#{k}"), k] }
  end
end
