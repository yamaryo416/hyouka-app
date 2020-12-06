class BathyesthesiaScale < ApplicationRecord
  belongs_to :patient

  enum right_upper_limb: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true
  enum left_upper_limb: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true
  enum right_lower_limb: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true
  enum left_lower_limb: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true
  enum right_finger: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true
  enum left_finger: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true
  enum right_toe: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true
  enum left_toe: {
    undefined: nil,
    zero: 0,
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.
      map { |k| [I18n.t("enums.bathyesthesia_scale.#{attr_name}.#{k}"), k] }
  end
end
