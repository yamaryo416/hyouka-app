class TendonReflexScale < ApplicationRecord
  include Scope

  belongs_to :patient
  enum jaw: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum abdominal: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum right_pectoral: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum left_pectoral: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum right_biceps: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum left_biceps: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum right_triceps: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum left_triceps: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum right_brachioradialis: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum left_brachioradialis: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum right_pronator: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum left_pronator: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum right_patellar_tendon: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum left_patellar_tendon: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum right_achilles_tendon: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true
  enum left_achilles_tendon: {
    undefined: nil,
    absent: 0,
    diminished: 1,
    normal: 2,
    slightly_exaggerated: 3,
    moderately_exaggerated: 4,
    markedly_exaggerated: 5,
  }, _prefix: true

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.
      map { |k| [I18n.t("enums.tendon_reflex_scale.#{attr_name}.#{k}"), k] }
  end
end
