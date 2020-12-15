class HdsrScale < ApplicationRecord
  include Scope

  TODAY_ATTRIBUTES = [
    :year,
    :month,
    :day,
    :day_of_the_week,
  ].map(&:freeze).freeze

  THREE_WORD_ATTRIBUTES = [
    :first_three_word,
    :second_three_word,
    :third_three_word,
  ].map(&:freeze).freeze

  SUBTRACTION_ATTRIBUTES = [
    :first_subtraction,
    :second_subtraction,
  ].map(&:freeze).freeze

  REVERSE_NUMBER_ATTRIBUTES = [
    :revese_three_number,
    :revese_four_number,
  ].map(&:freeze).freeze

  MEMORY_WORD_ATTRIBUTES = [
    :memory_first_word,
    :memory_second_word,
    :memory_third_word,
  ].map(&:freeze).freeze

  belongs_to :patient
  with_options inclusion: 0..1, allow_nil: true do
    validates :age
    validates :year
    validates :month
    validates :day
    validates :day_of_the_week
    validates :first_three_word
    validates :second_three_word
    validates :third_three_word
    validates :first_subtraction
    validates :second_subtraction
    validates :revese_three_number
    validates :revese_four_number
  end
  with_options inclusion: 0..2, allow_nil: true do
    validates :place
    validates :memory_first_word
    validates :memory_second_word
    validates :memory_third_word
  end
  with_options inclusion: 0..5, allow_nil: true do
    validates :five_goods
    validates :vegetables
  end
end
