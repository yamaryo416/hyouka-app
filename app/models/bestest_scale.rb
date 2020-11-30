class BestestScale < ApplicationRecord
  include ScaleModule
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

  def each_score
    each_score = {}
    attributes.each do |attr_name, value|
      if EXCLUDE_COLUMNS.include?(attr_name) || value.nil?
        next
      else
        score = send("#{attr_name}_before_type_cast")
        each_score.store(attr_name, score)
      end
    end
    each_score
  end

  def apa_score
    apa_score = 0
    APA_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        apa_score += score
      end
    end
    apa_score
  end

  def cpa_score
    cpa_score = 0
    CPA_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        cpa_score += score
      end
    end
    cpa_score
  end

  def sensory_function_score
    sensory_function_score = 0
    SENSORY_FUNCTION_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        sensory_function_score += score
      end
    end
    sensory_function_score
  end

  def dynamic_walking_score
    dynamic_walking_score = 0
    DYNAMIC_WALKING_ATTRIBUTES.each do |attr_name|
      if send(attr_name).present?
        score = send("#{attr_name}_before_type_cast")
        dynamic_walking_score += score
      end
    end
    dynamic_walking_score
  end

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

  def self.human_select_options(attr_name)
    send(attr_name.pluralize).keys.map { |k| [I18n.t("enums.bestest_scale.#{attr_name}.#{k}"), k] }
  end
end
